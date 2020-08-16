import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodlab/api/food_api.dart';
import 'package:foodlab/notifier/auth_notifier.dart';
import 'package:foodlab/notifier/food_notifier.dart';
import 'package:foodlab/screens/detail_food_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    FoodNotifier foodNotifier =
        Provider.of<FoodNotifier>(context, listen: false);
    getFoods(foodNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    print('building home');
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 25, left: 10, right: 10),
              child: authNotifier.user != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'FoodLab',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 63, 111, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MuseoModerno',
                          ),
                        ),
                        Text(
                          'Explore',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromRGBO(255, 63, 111, 1),
                      ),
                    ),
            ),
//            StreamBuilder<QuerySnapshot>(
//                stream: Firestore.instance
//                    .collection('foods')
//                    .orderBy('createdAt', descending: true)
//                    .snapshots(),
//                builder: (context, snapshot) {
//                  if (!snapshot.hasData) {
//                    return Column(
//                      children: <Widget>[
//                        Text(
//                          'loading...\n',
//                          style: TextStyle(
//                            color: Color.fromRGBO(255, 63, 111, 1),
//                          ),
//                        ),
//                        CircularProgressIndicator(
//                          backgroundColor: Color.fromRGBO(255, 63, 111, 1),
//                          valueColor: AlwaysStoppedAnimation<Color>(
//                            Color.fromRGBO(255, 138, 120, 1),
//                          ),
//                        ),
//                      ],
//                    );
//                  } else {
//                    return ListView.builder(
//                        shrinkWrap: true,
//                        physics: NeverScrollableScrollPhysics(),
//                        itemCount: snapshot.data.documents.length,
//                        itemBuilder: (context, index) {
//                          return Padding(
//                            padding: const EdgeInsets.symmetric(horizontal: 8),
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Container(
//                                  child: Text('username'),
//                                ),
//                                ClipRRect(
//                                  borderRadius: BorderRadius.circular(30),
//                                  child: Container(
//                                    width: MediaQuery.of(context).size.width,
//                                    child: snapshot.data.documents[index]
//                                                ['img'] !=
//                                            null
//                                        ? GestureDetector(
//                                            child: Container(
//                                              child: Image.network(
//                                                snapshot.data.documents[index]
//                                                    ['img'],
//                                                fit: BoxFit.cover,
//                                              ),
//                                            ),
//                                            onTap: () {
//                                              Navigator.push(context,
//                                                  MaterialPageRoute(
//                                                builder:
//                                                    (BuildContext context) {
//                                                  return FoodDetailPage(
//                                                    foodDetail: snapshot
//                                                        .data.documents[index],
//                                                  );
//                                                },
//                                              ));
//                                            },
//                                          )
//                                        : CircularProgressIndicator(
//                                            backgroundColor:
//                                                Color.fromRGBO(255, 63, 111, 1),
//                                          ),
//                                  ),
//                                ),
//                                Container(
//                                  child: Column(
//                                    crossAxisAlignment:
//                                        CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Text(
//                                        snapshot.data.documents[index]['name'],
//                                        style: TextStyle(
//                                          fontSize: 20,
//                                          fontWeight: FontWeight.bold,
//                                        ),
//                                      ),
//                                      SizedBox(
//                                        height: 3,
//                                      ),
//                                    ],
//                                  ),
//                                  padding: EdgeInsets.only(
//                                      top: 5, bottom: 10, left: 8),
//                                ),
//                                SizedBox(
//                                  height: 10,
//                                ),
//                              ],
//                            ),
//                          );
//                        });
//                  }
//                }),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: foodNotifier.foodList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(foodNotifier.foodList[index].userName),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: foodNotifier.foodList[index].img != null
                                ? GestureDetector(
                                    child: Container(
                                      child: Image.network(
                                        foodNotifier.foodList[index].img,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    onTap: () {
//                                Navigator.push(context,
//                                    MaterialPageRoute(
//                                      builder:
//                                          (BuildContext context) {
//                                        return FoodDetailPage(
//                                          foodDetail: foodNotifier.foodList[index],
//                                        );
//                                      },
//                                    ));
                                    },
                                  )
                                : CircularProgressIndicator(
                                    backgroundColor:
                                        Color.fromRGBO(255, 63, 111, 1),
                                  ),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                foodNotifier.foodList[index].name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(top: 5, bottom: 10, left: 8),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
