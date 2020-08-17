import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';

class FoodDetailPage extends StatelessWidget {
  final String imgUrl;
  final String imageName;
  final String imageCaption;
  final String userName;
  final DateTime createdTimeOfPost;

  FoodDetailPage({
    @required this.imgUrl,
    @required this.imageName,
    @required this.imageCaption,
    this.userName,
    this.createdTimeOfPost,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 30, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Details',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 138, 120, 1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    imageName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    imageCaption,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 40),
                  userName != null
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            child: GradientText(
                              userName,
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(255, 138, 120, 1),
                                  Color.fromRGBO(255, 63, 111, 1),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'MuseoModerno',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Text(
                          '',
                        ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      DateFormat.yMMMd().add_jm().format(
                            createdTimeOfPost,
                          ),
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(255, 138, 120, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
