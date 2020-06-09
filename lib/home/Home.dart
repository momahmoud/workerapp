import 'package:flutter/material.dart';
import 'package:workerapp/services/auth.dart';
import '../login_Singup/Widget/bezierContainer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workerapp/SEARCH/search.dart';
import 'package:workerapp/services/auth_service.dart';
import '../login_Singup/Widget/home_post.dart';
class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  Auth auth;
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'ع ',
          style: GoogleFonts.lemonada(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff000090),
          ),
          children: [
            TextSpan(
              text: 'ا م',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: '  ل',
              style: TextStyle(color: Color(0xff000090), fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(icon: Icon(Icons.exit_to_app), onPressed: () => auth.logout()),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0,right: 100),
                  child: _title(),
                ),
                SizedBox(height: 30,),
                searchFiled(),
                SizedBox(height:  20,),
                Container(
                    height:400,
                    child: Post_worker()),

                Expanded(
                  flex: 2,
                  child: SizedBox(),
                )
              ],
            ),
          ),
          Positioned(
              top: -MediaQuery.of(context).size.height * .20,
              right: -MediaQuery.of(context).size.width * .5,
              child: BezierContainer())
        ],
      ),
    )));
  }
}
