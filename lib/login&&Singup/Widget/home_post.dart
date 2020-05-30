import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Post_worker extends StatefulWidget {
  @override
  _Post_workerState createState() => _Post_workerState();
}

class _Post_workerState extends State<Post_worker> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
        child: Card(
          color: Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(30)),
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.blue,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.white,
                        backgroundImage: AssetImage('images/ahmed.jpg'),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "رضوان البرنس ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          " ميكانيكي سيارات متخصص في الدوكو",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.circular(30)),
                              clipBehavior: Clip.antiAlias,
                              onPressed: () {},
                              color: Colors.white,
                              child: Text(
                                'المزيد....',
                                style: TextStyle(color: Colors.blue,    fontWeight: FontWeight.bold,),
                              )),
                        )
                      ],
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
//color: Colors.blue,
//shape: RoundedRectangleBorder(
//borderRadius: BorderRadiusDirectional.circular(30)),
//
//clipBehavior: Clip.antiAlias,
