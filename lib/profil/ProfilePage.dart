import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workerapp/Maseege/Maseege_page.dart';
import 'package:workerapp/addDataAndSkills/addData.dart';
import 'package:workerapp/utils/constant.dart';
import 'dart:async';
import 'edit_profile.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:workerapp/models/user_data.dart';
import 'package:workerapp/models/user_model.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title, this.userId}) : super(key: key);

  final String title;
  final String userId;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
   bool isLoading = false;
  int postCount = 0;
  List<UserModel> posts = [];

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 5, vsync: this);
    getProfilePosts();
    
  }
   getProfilePosts() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await postsRef
        .document(widget.userId)
        .collection('userPost')
        .orderBy(
          'timestamp',
          descending: true,
        )
        .getDocuments();
      setState((){
        isLoading = false;
      });
  }


  _displayButton(UserModel user) {
    return user.id == Provider.of<UserData>(context).currentUserId
        ? Container(
            width: 190,
            child: FlatButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileEditScreen(
                      user: user,
                    ),
                  ),
                );
              },
              child: Text(
                'تعديل البيانات',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    var usr = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'الصفحه الشخصيه ',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.indigo[500],
       
      ),
      body: usr == null? Text('no') : FutureBuilder(
        future: postsRef.document(usr.id).collection('userPost').getDocuments(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
           
          print(usr.name);
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.7),
                          blurRadius: 50,
                          spreadRadius: 50,
                        )
                      ],
                      color: Colors.indigo[500],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(800),
                        bottomLeft: Radius.circular(800),
                      )),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 135),
                            child: Container(
                              height: 105,
                              width: 105,
                              decoration: BoxDecoration(
                                  color: Colors.indigo[500],
                                  borderRadius: BorderRadius.circular(52.5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.yellow,
                                      spreadRadius: 2,
                                    )
                                  ]),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: 
                                usr.imageUrl.isEmpty
                              ? AssetImage(
                                  'assets/pics/user.jpg',
                                )
                              : CachedNetworkImageProvider(
                                  usr.imageUrl,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        usr.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: Text(
                          usr.skills,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
                _displayButton(usr),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 10, left: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 230,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.7),
                              blurRadius: 50,
                              spreadRadius: 50,
                            )
                          ],
                          color: Colors.indigo[500],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          )),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          title: Text('رقم التليفون'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(usr.phone),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  textColor: Colors.white,
                                                  color: Colors.blueAccent,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        new Text(
                                                          "اغلق",
                                                        ),
                                                        Icon(Icons.close),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                FlatButton(
                                                  onPressed: () async {
                                                    FlutterPhoneDirectCaller
                                                        .callNumber(usr.phone);
                                                  },
                                                  textColor: Colors.white,
                                                  color: Colors.blueAccent,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        new Text(
                                                          "اتصل",
                                                        ),
                                                        Icon(Icons.phone)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo[500],
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.indigo[500],
                                          spreadRadius: 1,
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'التليفون',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          title: Text('العنوان'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(usr.address)
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  textColor: Colors.white,
                                                  color: Colors.blueAccent,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        new Text(
                                                          "اغلق",
                                                        ),
                                                        Icon(Icons.close),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo[500],
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.indigo[500],
                                          spreadRadius: 1,
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'العنوان',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: AlertDialog(
                                            title: Text('العمر'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(usr.age.toString()),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    textColor: Colors.white,
                                                    color: Colors.blueAccent,
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      child: Row(
                                                        children: <Widget>[
                                                          new Text(
                                                            "اغلق",
                                                          ),
                                                          Icon(Icons.close),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.indigo[500],
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.indigo[500],
                                            spreadRadius: 1,
                                          )
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            'العمر',
                                            style: TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          title: Text('المهارات'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(usr.skills),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  textColor: Colors.white,
                                                  color: Colors.blueAccent,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        new Text(
                                                          "اغلق",
                                                        ),
                                                        Icon(Icons.close),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo[500],
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.indigo[500],
                                          spreadRadius: 1,
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.work,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'المهارات',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => new Mseege()));
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo[500],
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.indigo[500],
                                          spreadRadius: 1,
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.message,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'رسالة',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
