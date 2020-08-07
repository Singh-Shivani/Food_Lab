import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Uploader extends StatefulWidget {
  final File file;

  Uploader({this.file});

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://foodlab-d25f0.appspot.com');
  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;
          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;
          return Column(
            children: <Widget>[
              if (_uploadTask.isComplete) Text('Done!!!'),
              if (_uploadTask.isPaused)
                FlatButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: _uploadTask.resume,
                ),
              if (_uploadTask.isInProgress)
                FlatButton(
                  child: Icon(Icons.pause),
                  onPressed: _uploadTask.pause,
                ),
              LinearProgressIndicator(value: progressPercent),
              Text('${(progressPercent * 100).toStringAsFixed(2)} %'),
            ],
          );
        },
      );
    } else {
      return FlatButton.icon(
        color: Colors.white,
        onPressed: _startUpload,
        icon: Icon(
          Icons.file_upload,
          color: Color.fromRGBO(255, 63, 111, 1),
        ),
        label: Text(
          'Upload img',
          style: TextStyle(
            color: Color.fromRGBO(255, 63, 111, 1),
          ),
        ),
      );
    }
  }
}
