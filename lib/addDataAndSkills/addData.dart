import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workerapp/login&&Singup/Widget/bezierContainer.dart';
import 'package:workerapp/models/user_model.dart';
import 'package:workerapp/services/database_service.dart';
import 'package:workerapp/services/storage_service.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _skillsController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  String _name = '';
  String _skills = '';
  String _address = '';
  String _phone = '';
  double _age = 0;
  File _image;
  bool _isLoading = false;

   _showSelectImage() {
    return Platform.isIOS ? _iosBottomSheet() : _androidDialog();
  }

  _iosBottomSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Add Photo'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () => _handleImage(ImageSource.camera),
              child: Text('Take Photo'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => _handleImage(ImageSource.gallery),
              child: Text('Choose from Gallery'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        );
      },
    );
  }

  _androidDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Add Photo'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Take Photo'),
                onPressed: () => _handleImage(ImageSource.camera),
              ),
              SimpleDialogOption(
                child: Text('Choose from Gallery'),
                onPressed: () => _handleImage(ImageSource.gallery),
              ),
              SimpleDialogOption(
                child: Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  _handleImage(ImageSource source) async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      imageFile = await _cropImage(imageFile);
      setState(() {
        _image = imageFile;
      });
    }
  }

  _cropImage(File imageFile) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    return croppedImage;
  }

  _submit() async {
    if (!_isLoading && _image != null && _name.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      String imageUrl = await StorageService.uploadPost(_image);
      UserModel post = UserModel(
        imageUrl: imageUrl,
        name: _name,
        phone: _phone,
        age: _age,
        address: _address,
        skills: _skills,
      );

      DatabaseService.createPost(post);

      _nameController.clear();
      _ageController.clear();
      _skillsController.clear();
      _phoneController.clear();
      _addressController.clear();
      setState(() {
        _name = '';
        _age = 0;
        _phone = '';
        _address = '';
        _skills = '';
        _image = null;
        _isLoading = false;
      });
    }
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
                      AddDattaform(),
                      SizedBox(
                        height: 20,
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
//                  Align(
//                    alignment: Alignment.bottomCenter,
//                    child: _loginAccountLabel(),
//                  ),
          Positioned(top: 50, left: 0, child: _backButton()),
          Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer())
        ],
      ),
    )));
  }

  Widget _submitButton() {
    return InkWell(
      onTap: _submit,
          child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35)),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 60),
              child: Text(
                'حفظ ',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 80),
              child: Icon(
                Icons.save,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'بيا',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff000090),
          ),
          children: [
            TextSpan(
              text: 'نات ال',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'عامل',
              style: TextStyle(color: Color(0xff000090), fontSize: 30),
            ),
          ]),
    );
  }

  Widget AddDattaform() {
    final width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: 300,
        height: 310.0,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (input) => _name = input,
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'الاسم ',
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    fillColor: Colors.blue,
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (input) => _skills = input,
                controller: _skillsController,
                decoration: InputDecoration(
                    labelText: 'المهارات',
                    icon: Icon(Icons.work),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    fillColor: Colors.blue,
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (input) => _address = input,
                controller: _addressController,
                decoration: InputDecoration(
                    labelText: 'العنوان',
                    icon: Icon(Icons.location_on),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    fillColor: Colors.blue,
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (input) => _phone = input,
                controller: _phoneController,
                decoration: InputDecoration(
                    labelText: 'رقم التليفون ',
                    icon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    fillColor: Colors.blue,
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (input) => _age = double.parse(input),
                controller: _ageController,
                decoration: InputDecoration(
                    labelText: 'العمر',
                    icon: Icon(Icons.contact_mail),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    fillColor: Colors.blue,
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true),
              ),
              GestureDetector(
                    onTap: _showSelectImage,
                    child: Container(
                      height: width,
                      width: width,
                      color: Colors.grey[300],
                      child: _image == null
                          ? Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 130,
                            )
                          : Image(
                              image: FileImage(
                                _image,
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
