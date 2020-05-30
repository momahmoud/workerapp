import 'package:flutter/material.dart';
import 'package:workerapp/services/auth_service.dart';
import 'signup.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widget/bezierContainer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;

  Widget _backButton() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
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
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            SizedBox(
              height: 3,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
                          child: TextFormField(
                  validator: title == 'الايميل'
                      ? (input) =>
                          !input.contains('@') ? 'يجب ان يحتوي علي @' : null
                      : title == 'الرقم السري'
                          ? (input) => input.length < 6
                              ? 'يجب ان يكون اكبر من 6 حروف'
                              : null
                          : null,
                  onSaved: (input) =>
                      title == 'الايميل' ? _email = input.trim() 
                      : title == 'الرقم السري' ? _password = input : null,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xff9FAFDF),
                      filled: true)),
            )
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AuthService.signinUser(_email.trim(), _password.trim());
    }
  }

  Widget _submitButton() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: _submit,
        child: Container(
          height: 45,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 5),
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
          child: Center(
            child: Text(
              'تسجيل دخول',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _facebookButton() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(
          vertical: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1959a9),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('f',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff2872ba),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: Text('تسجيل دخول بالفيس بوك',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'اذا لم تمتلك حساب ؟',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Text(
                'حساب جديد',
                style: TextStyle(
                    color: Color(0xff0000f0),
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'ع ',
            style: GoogleFonts.portLligatSans(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xff0000f0),
            ),
            children: [
              TextSpan(
                text: 'ا م',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              TextSpan(
                text: '  ل',
                style: TextStyle(color: Color(0xff0000f0), fontSize: 30),
              ),
            ]),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("الايميل"),
        _entryField("الرقم السري", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: SizedBox(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
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

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.centerRight,
                    child: Text('نسيت الرقم السري ؟',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  //  _divider(),
                  _facebookButton(),
                  Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _createAccountLabel(),
            Align(
              alignment: Alignment.bottomCenter,
              child: _createAccountLabel(),
            ),
            Positioned(top: 50, left: 0, child: _backButton()),
            Positioned(
                top: -MediaQuery.of(context).size.height * .18,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer())
          ],
        ),
      ))),
    );
  }
}
