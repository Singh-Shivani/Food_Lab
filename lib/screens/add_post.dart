import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:foodlab/api/food_api.dart';
import 'package:foodlab/screens/upload_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:foodlab/model/food.dart';

import 'home_page.dart';

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  Food food = Food();
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

  _save() async {
    uploadFoodAndImages(food, _imageFile, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Color.fromRGBO(252, 121, 101, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.photo_library,
                          ),
                          onPressed: () {
                            _pickImage(ImageSource.gallery);
                          },
                        ),
                        Text('Select an image\nfrom phone gallery'),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                          ),
                          onPressed: () {
                            _pickImage(ImageSource.camera);
                          },
                        ),
                        Text('Click an image'),
                      ],
                    ),
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    _imageFile != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width - 20,
                                child: Image.file(
                                  _imageFile,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
//                              Uploader(file: _imageFile)
                            ],
                          )
                        : Center(child: Text('No file is selected')),
                  ],
                ),
                Container(
                  child: TextField(
                    onChanged: (String value) {
                      food.name = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Name the food',
                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    onChanged: (String value) {
                      food.caption = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Write a caption',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _save();
                  },
                  child: Text('Post'),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//android:name="com.yalantis.ucrop.UCropActivity" android:screenOrientation="portrait"
//            android:theme="@style/Theme.AppCompat.Light.NoActionBar"
//
