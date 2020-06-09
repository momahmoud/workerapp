import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workerapp/services/auth.dart';
import 'package:workerapp/services/auth_service.dart';
import 'Widget/bezierContainer.dart';
import 'loginPage.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  
  Map<String, String> _authData = {
    'name':'',
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {

        
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
      
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      print(error);
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }
 

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_right, color: Colors.black),
            ),
            Text('عوده',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: isPassword? _passwordController : null,
              validator: title == 'الايميل'
                  ? (input) =>
                      !input.contains('@') ? 'يجب ان يحتوي علي @' : null
                  : title == 'الاسم'
                      ? (input) =>
                          input.length < 6 ? 'يجب ان يكون اكبر من 8 حروف' : null
                      : title == 'الرقم السري'
                          ? (input) => input.length < 6
                              ? 'يجب ان يكون اكبر من 6 حروف'
                              : null
                          : null,
              onSaved: (input) => title == 'الايميل'
                  ? _authData['email'] = input
                  : title == 'الاسم' 
                  ? _authData['name'] = input :
                  title == 'الرقم السري' ?
                   _authData['password'] = input : null,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xff9FAFDF),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return _isLoading ? CircularProgressIndicator() :  InkWell(
      onTap: _submit,
          child:  Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff0000f0), Color(0xff000090)])),
        child: Text(
          'حساب جديد',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ' لو لديك حساب بالتأكيد ؟',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                'تسجيل دخول',
                style: TextStyle(
                    color: Color(0xfff79c4f),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'ع ',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff000090),
          ),
          children: [
            TextSpan(
              text: 'ا م ',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: '  ل',
              style: TextStyle(color: Color(0xff000090), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: <Widget>[
          _entryField("الاسم"),
          _entryField("الايميل"),
          _entryField("الرقم السري", isPassword: true),
        ],
      ),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: _title(),
                ),
                SizedBox(
                  height: 50,
                ),
               Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _emailPasswordWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        _submitButton(),
                      ],
                    ),
                  ),
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _loginAccountLabel(),
          ),
          Positioned(top: 50, left: 0, child: _backButton()),
          Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer())
        ],
      ),
    )));
  }
}
