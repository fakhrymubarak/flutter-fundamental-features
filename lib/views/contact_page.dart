import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  late List<Contact>? _contacts;

  @override
  void initState() {
    refreshContacts();
    super.initState();
  }

  Future<void> refreshContacts() async {
    var contacts = (await ContactsService.getContacts(
        withThumbnails: false, iOSLocalizedLabels: false));
    setState(() {
      _contacts = contacts;
    });

    for (final contact in contacts) {
      ContactsService.getAvatar(contact).then((avatar) {
        if (avatar == null) return;
        setState(() => contact.avatar = avatar);
      });
    }
  }

  _openContactForm() async {
    try {
      var _ = await ContactsService.openContactForm(iOSLocalizedLabels: false);
      refreshContacts();
    } on FormOperationException catch (e) {
      switch (e.errorCode) {
        case FormOperationErrorCode.FORM_OPERATION_CANCELED:
        case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
        case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
        default:
          print(e.errorCode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contacts Plugin Example',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _openContactForm,
      ),
      body: SafeArea(
        child: _contacts == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _contacts?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Contact c = _contacts!.elementAt(index);
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ContactDetailsPage(
                                c,
                                onContactDeviceSave:
                                    contactOnDeviceHasBeenUpdated,
                              )));
                    },
                    leading: (c.avatar != null && c.avatar!.isNotEmpty)
                        ? CircleAvatar(backgroundImage: MemoryImage(c.avatar!))
                        : CircleAvatar(child: Text(c.initials())),
                    title: Text(c.displayName ?? ""),
                  );
                },
              ),
      ),
    );
  }

  void contactOnDeviceHasBeenUpdated(Contact contact) {
    setState(() {
      var id = _contacts!.indexWhere((c) => c.identifier == contact.identifier);
      _contacts![id] = contact;
    });
  }
}

class ContactDetailsPage extends StatelessWidget {
  ContactDetailsPage(this._contact, {required this.onContactDeviceSave});

  final Contact _contact;
  final Function(Contact) onContactDeviceSave;

  _openExistingContactOnDevice(BuildContext context) async {
    try {
      var contact = await ContactsService.openExistingContact(_contact,
          iOSLocalizedLabels: false);
      onContactDeviceSave(contact);
      Navigator.of(context).pop();
    } on FormOperationException catch (e) {
      switch (e.errorCode) {
        case FormOperationErrorCode.FORM_OPERATION_CANCELED:
        case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
        case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
        default:
          print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_contact.displayName ?? ""),
        actions: <Widget>[
//          IconButton(
//            icon: const Icon(Icons.share),
//            onPressed: () => shareVCFCard(context, contact: _contact),
//          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => ContactsService.deleteContact(_contact),
          ),
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UpdateContactsPage(
                  contact: _contact,
                ),
              ),
            ),
          ),
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _openExistingContactOnDevice(context)),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Name"),
              trailing: Text(_contact.givenName ?? ""),
            ),
            ListTile(
              title: Text("Middle name"),
              trailing: Text(_contact.middleName ?? ""),
            ),
            ListTile(
              title: Text("Family name"),
              trailing: Text(_contact.familyName ?? ""),
            ),
            ListTile(
              title: Text("Prefix"),
              trailing: Text(_contact.prefix ?? ""),
            ),
            ListTile(
              title: Text("Suffix"),
              trailing: Text(_contact.suffix ?? ""),
            ),
            ListTile(
              title: Text("Birthday"),
              trailing: Text(_contact.birthday != null
                  ? DateFormat('dd-MM-yyyy').format(_contact.birthday!)
                  : ""),
            ),
            ListTile(
              title: Text("Company"),
              trailing: Text(_contact.company ?? ""),
            ),
            ListTile(
              title: Text("Job"),
              trailing: Text(_contact.jobTitle ?? ""),
            ),
            ListTile(
              title: Text("Account Type"),
              trailing: Text((_contact.androidAccountType != null)
                  ? _contact.androidAccountType.toString()
                  : ""),
            ),
            ItemsTile("Phones", _contact.phones!),
            ItemsTile("Emails", _contact.emails!)
          ],
        ),
      ),
    );
  }
}

class ItemsTile extends StatelessWidget {
  ItemsTile(this._title, this._items);

  final List<Item> _items;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(title: Text(_title)),
        Column(
          children: [
            for (var i in _items)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListTile(
                  title: Text(i.label ?? ""),
                  trailing: Text(i.value ?? ""),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class AddContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  Contact contact = Contact();
  PostalAddress address = PostalAddress(label: "Home");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a contact"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _formKey.currentState?.save();
              contact.postalAddresses = [address];
              ContactsService.addContact(contact);
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.save, color: Colors.white),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'First name'),
                onSaved: (v) => contact.givenName = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Middle name'),
                onSaved: (v) => contact.middleName = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last name'),
                onSaved: (v) => contact.familyName = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Prefix'),
                onSaved: (v) => contact.prefix = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Suffix'),
                onSaved: (v) => contact.suffix = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                onSaved: (v) =>
                    contact.phones = [Item(label: "mobile", value: v)],
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                onSaved: (v) =>
                    contact.emails = [Item(label: "work", value: v)],
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Company'),
                onSaved: (v) => contact.company = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Job'),
                onSaved: (v) => contact.jobTitle = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Street'),
                onSaved: (v) => address.street = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'City'),
                onSaved: (v) => address.city = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Region'),
                onSaved: (v) => address.region = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Postal code'),
                onSaved: (v) => address.postcode = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Country'),
                onSaved: (v) => address.country = v,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpdateContactsPage extends StatefulWidget {
  UpdateContactsPage({required this.contact});

  final Contact contact;

  @override
  _UpdateContactsPageState createState() => _UpdateContactsPageState();
}

class _UpdateContactsPageState extends State<UpdateContactsPage> {
  late Contact contact;
  PostalAddress address = PostalAddress(label: "Home");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    contact = widget.contact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Contact"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () async {
              _formKey.currentState?.save();
              contact.postalAddresses = [address];
              await ContactsService.updateContact(contact);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ContactListPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: contact.givenName ?? "",
                decoration: const InputDecoration(labelText: 'First name'),
                onSaved: (v) => contact.givenName = v,
              ),
              TextFormField(
                initialValue: contact.middleName ?? "",
                decoration: const InputDecoration(labelText: 'Middle name'),
                onSaved: (v) => contact.middleName = v,
              ),
              TextFormField(
                initialValue: contact.familyName ?? "",
                decoration: const InputDecoration(labelText: 'Last name'),
                onSaved: (v) => contact.familyName = v,
              ),
              TextFormField(
                initialValue: contact.prefix ?? "",
                decoration: const InputDecoration(labelText: 'Prefix'),
                onSaved: (v) => contact.prefix = v,
              ),
              TextFormField(
                initialValue: contact.suffix ?? "",
                decoration: const InputDecoration(labelText: 'Suffix'),
                onSaved: (v) => contact.suffix = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                onSaved: (v) =>
                    contact.phones = [Item(label: "mobile", value: v)],
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                onSaved: (v) =>
                    contact.emails = [Item(label: "work", value: v)],
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                initialValue: contact.company ?? "",
                decoration: const InputDecoration(labelText: 'Company'),
                onSaved: (v) => contact.company = v,
              ),
              TextFormField(
                initialValue: contact.jobTitle ?? "",
                decoration: const InputDecoration(labelText: 'Job'),
                onSaved: (v) => contact.jobTitle = v,
              ),
              TextFormField(
                initialValue: address.street ?? "",
                decoration: const InputDecoration(labelText: 'Street'),
                onSaved: (v) => address.street = v,
              ),
              TextFormField(
                initialValue: address.city ?? "",
                decoration: const InputDecoration(labelText: 'City'),
                onSaved: (v) => address.city = v,
              ),
              TextFormField(
                initialValue: address.region ?? "",
                decoration: const InputDecoration(labelText: 'Region'),
                onSaved: (v) => address.region = v,
              ),
              TextFormField(
                initialValue: address.postcode ?? "",
                decoration: const InputDecoration(labelText: 'Postal code'),
                onSaved: (v) => address.postcode = v,
              ),
              TextFormField(
                initialValue: address.country ?? "",
                decoration: const InputDecoration(labelText: 'Country'),
                onSaved: (v) => address.country = v,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
