import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workerapp/login&&Singup/loginPage.dart';


import 'home/Home.dart';
import 'login&&Singup/Widget/home_icon.dart';
import 'models/user_data.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
   Widget _getScreenId() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
          return MainScreen();
        }else{
          return LoginPage();
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ChangeNotifierProvider(
       create: (context) => UserData(),
          child: MaterialApp(
        title: 'Flutter  ',
        theme: ThemeData(
           primarySwatch: Colors.blue,
           textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
             body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
           ),
        ),
        debugShowCheckedModeBanner: false,
        home: _getScreenId(),
      ),
    );
  }
}
