import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rpl_apps_flutter/themes/button_styles.dart';
import 'package:rpl_apps_flutter/utils/notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _setNotificationAndroid() {
    NotificationService notificationService = NotificationService();
    notificationService.showNotifications();
  }

  Future<void> _askPermissions(String? routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        Get.toNamed(routeName);
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      const snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      const snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _setNotificationAndroid();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Notification'),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('On Development')));
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Special Notification'),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/geo_locator');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Geo-Location'),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/camera');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Camera Access'),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/audio');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Speaker Access'),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/mic');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Microphone Access'),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _askPermissions('/contact');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Contact Book'),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/biometrics');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Fingerprint and Face Access'),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/connectivity');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Cellular and Wifi Access'),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/bluetooth');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Bluetooth Access'),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/ir');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Infrared Access'),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/nfc');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('NFC Access'),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/sensors');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text(
                          'Accelerometer, Magnetometer, and Gyroscope Access',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/phoneNumber');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Cellular Number Access'),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/deviceInfo');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Device Info (Device ID)'),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/cache');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Non-Connection (Caching)'),
                      ),
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
