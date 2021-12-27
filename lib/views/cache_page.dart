import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

const url = 'https://blurha.sh/assets/images/img1.jpg';

class CachePage extends StatefulWidget {
  const CachePage({Key? key}) : super(key: key);

  @override
  _CachePageState createState() => _CachePageState();
}

class _CachePageState extends State<CachePage> {
  Stream<FileResponse>? fileStream;

  void _downloadFile() {
    setState(() {
      fileStream = DefaultCacheManager().getFileStream(url, withProgress: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (fileStream == null) {
      return Scaffold(
        appBar: null,
        body: const SafeArea(
          child: ListTile(
              title: Text('Tap the floating action button to download.')),
        ),
        floatingActionButton: Fab(
          downloadFile: _downloadFile,
        ),
      );
    }
    return DownloadPage(
      fileStream: fileStream!,
      downloadFile: _downloadFile,
      clearCache: _clearCache,
      removeFile: _removeFile,
    );
  }

  void _clearCache() {
    DefaultCacheManager().emptyCache();
    setState(() {
      fileStream = null;
    });
  }

  void _removeFile() {
    DefaultCacheManager().removeFile(url).then((value) {
      //ignore: avoid_print
      print('File removed');
    }).onError((error, stackTrace) {
      //ignore: avoid_print
      print(error);
    });
    setState(() {
      fileStream = null;
    });
  }
}

/*DOWNLOAD PAGE*/
class DownloadPage extends StatelessWidget {
  final Stream<FileResponse> fileStream;
  final VoidCallback downloadFile;
  final VoidCallback clearCache;
  final VoidCallback removeFile;

  const DownloadPage({
    Key? key,
    required this.fileStream,
    required this.downloadFile,
    required this.clearCache,
    required this.removeFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FileResponse>(
      stream: fileStream,
      builder: (context, snapshot) {
        Widget body;

        var loading = !snapshot.hasData || snapshot.data is DownloadProgress;

        if (snapshot.hasError) {
          body = ListTile(
            title: const Text('Error'),
            subtitle: Text(snapshot.error.toString()),
          );
        } else if (loading) {
          body = ProgressIndicator(progress: snapshot.data as DownloadProgress);
        } else {
          body = FileInfoWidget(
            fileInfo: snapshot.data as FileInfo,
            clearCache: clearCache,
            removeFile: removeFile,
          );
        }

        return Scaffold(
          appBar: null,
          body: body,
          floatingActionButton: !loading
              ? Fab(
                  downloadFile: downloadFile,
                )
              : null,
        );
      },
    );
  }
}

/* FILE INFO WIDGET */
class FileInfoWidget extends StatelessWidget {
  final FileInfo fileInfo;
  final VoidCallback clearCache;
  final VoidCallback removeFile;

  const FileInfoWidget({
    Key? key,
    required this.fileInfo,
    required this.clearCache,
    required this.removeFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: const Text('Original URL'),
          subtitle: Text(fileInfo.originalUrl),
        ),
        if (fileInfo.file != null)
          ListTile(
            title: const Text('Local file path'),
            subtitle: Text(fileInfo.file.path),
          ),
        ListTile(
          title: const Text('Loaded from'),
          subtitle: Text(fileInfo.source.toString()),
        ),
        ListTile(
          title: const Text('Valid Until'),
          subtitle: Text(fileInfo.validTill.toIso8601String()),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          // ignore: deprecated_member_use
          child: RaisedButton(
            child: const Text('CLEAR CACHE'),
            onPressed: clearCache,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          // ignore: deprecated_member_use
          child: RaisedButton(
            child: const Text('REMOVE FILE'),
            onPressed: removeFile,
          ),
        ),
      ],
    );
  }
}

/* FAB */
class Fab extends StatelessWidget {
  final VoidCallback downloadFile;

  const Fab({Key? key, required this.downloadFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: downloadFile,
      tooltip: 'Download',
      child: const Icon(Icons.cloud_download),
    );
  }
}

/* Progress Indicator */
class ProgressIndicator extends StatelessWidget {
  final DownloadProgress progress;

  const ProgressIndicator({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              value: progress.progress,
            ),
          ),
          const SizedBox(width: 20.0),
          const Text('Downloading'),
        ],
      ),
    );
  }
}
