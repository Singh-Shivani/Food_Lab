import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

//class AddPostPage extends StatefulWidget {
//  @override
//  _AddPostPageState createState() => _AddPostPageState();
//}
//
//class _AddPostPageState extends State<AddPostPage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: ImageCapture(),
//    );
//  }
//}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final selected = await ImagePicker().getImage(source: source);
    setState(() {
      _imageFile = File(selected.path);
    });
  }

//  Future<void> _cropImage() async {
//    File cropped = await ImageCropper.cropImage(
//        sourcePath: _imageFile.path,
//        androidUiSettings: AndroidUiSettings(
//            toolbarTitle: 'Crop Image',
//            toolbarColor: Colors.deepOrange,
//            toolbarWidgetColor: Colors.white,
//            initAspectRatio: CropAspectRatioPreset.original,
//            lockAspectRatio: false),
//        iosUiSettings: IOSUiSettings(
//          title: 'Cropper',
//        ));
//    setState(() {
//      _imageFile = cropped ?? _imageFile;
//    });
//  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: () {
              _pickImage(ImageSource.gallery);
            },
          ),
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: () {
              _pickImage(ImageSource.camera);
            },
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              _imageFile != null
                  ? Column(
                      children: <Widget>[
                        Image.file(_imageFile),
                        Row(
                          children: <Widget>[
                            FlatButton(
                              child: Icon(Icons.crop),
//                              onPressed: _cropImage,
                            ),
                            FlatButton(
                              child: Icon(Icons.refresh),
                              onPressed: _clear,
                            ),
                          ],
                        ),
                        Uploader(file: _imageFile)
                      ],
                    )
                  : Text('Select Image file'),
            ],
          ),
        ],
      ),
    );
  }
}

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
                  child: Icon(Icons.play_arrow),
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
        onPressed: _startUpload,
        icon: Icon(Icons.file_upload),
        label: Text('Upload img'),
      );
    }
  }
}
//android:name="com.yalantis.ucrop.UCropActivity" android:screenOrientation="portrait"
//            android:theme="@style/Theme.AppCompat.Light.NoActionBar"
//
