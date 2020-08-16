import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:foodlab/api/food_api.dart';
import 'package:foodlab/screens/upload_image.dart';
import 'package:foodlab/widget/custom_raised_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:foodlab/model/food.dart';

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
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Post',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 138, 120, 1),
                  ),
                ),
                SizedBox(height: 10),
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
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  _pickImage(ImageSource.gallery);
                                },
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Card(
                                    elevation: 10,
                                    shadowColor:
                                        Color.fromRGBO(255, 63, 111, 1),
                                    child: Icon(Icons.photo_library, size: 50),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _pickImage(ImageSource.camera);
                                },
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Card(
                                    elevation: 8,
                                    shadowColor:
                                        Color.fromRGBO(255, 138, 120, 1),
                                    child: Icon(Icons.camera_alt, size: 50),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 40),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  child: TextField(
                    onChanged: (String value) {
                      food.name = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name your food',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextField(
                    onChanged: (String value) {
                      food.caption = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Write a caption',
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _save();
                    },
                    child: CustomRaisedButton(
                      buttonText: 'Post',
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
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
