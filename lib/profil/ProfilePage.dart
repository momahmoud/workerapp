import 'package:flutter/material.dart';
import 'package:workerapp/addDataAndSkills/addData.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    
    super.initState();
    tabController = new TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'الصفحه الشخصيه ',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.indigo[500],
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddData())))
        ],
      ),
      body: Container(
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
                            backgroundImage: AssetImage('images/ahmed.jpg'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'رضوان البرنس',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Text(
                      'ميكانيكي سيارات متخصص في الدوكو',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ),
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
                          Container(
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
                          Container(
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
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
                          Container(
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
                          Padding(
                            padding: const EdgeInsets.all(4.0),
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
                                padding: const EdgeInsets.only(top: 0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'f',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'الفيس ',
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
      ),
    );
  }
}
