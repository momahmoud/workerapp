import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workerapp/login_Singup/loginPage.dart';
import 'package:workerapp/models/user_model.dart';
import 'package:workerapp/services/auth.dart';
import './login_Singup/Widget/home_icon.dart';
import 'package:workerapp/splashScreen/SPLACH.dart';

import 'models/user_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget _getScreenId() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
          return MainScreen();
        } else {
          return Splach();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: UserData(),
        ),
        ChangeNotifierProvider.value(
          value: UserModel(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'عامل',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
              body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: auth.isAuth ? MainScreen() : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? Splach()
                              : LoginPage(),
                    ),
        ),
      ),
    );
  }
}
