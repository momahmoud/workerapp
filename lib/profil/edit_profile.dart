import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workerapp/models/user_model.dart';
import 'package:workerapp/services/database_service.dart';
import 'package:workerapp/services/storage_service.dart';

class ProfileEditScreen extends StatefulWidget {
  final UserModel user;

  ProfileEditScreen({this.user});

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  bool _isLoading = false;
  String _name = '';
  String _skills = '';
  String _address = '';
  String _phone = '';
  double _age = 0;

  

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _skills = widget.user.skills;
    _address = widget.user.address;
    _age = widget.user.age;
    _phone = widget.user.phone;
  }

  _handledImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _image = imageFile;
      });
    }
  }

  _displayProfileImage() {
    if (_image == null) {
      if (widget.user.imageUrl.isEmpty) {
        return AssetImage('assets/pics/user.jpg');
      } else {
        return CachedNetworkImageProvider(widget.user.imageUrl);
      }
    } else {
      return FileImage(_image);
    }
  }

  void _submit() async {
    if (_formKey.currentState.validate() && !_isLoading) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      String _profileImageUrl = '';

      if (_image == null) {
        _profileImageUrl = widget.user.imageUrl;
      } else {
        _profileImageUrl = await StorageService.uploadUserProfileImage(
          widget.user.imageUrl,
          _image,
        );
      }
      UserModel user = UserModel(
        id: widget.user.id,
        name: _name,
        skills: _skills,
        imageUrl: _profileImageUrl,
        address: _address,
        age: _age,
        phone: _phone,
      );

      DatabaseService.updateUser(user);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'تعديل الصفحة الشخصية',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            _isLoading
                ? LinearProgressIndicator(
                    backgroundColor: Colors.blue[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  )
                : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: _displayProfileImage(),
                      ),
                      FlatButton(
                        onPressed: _handledImageFromGallery,
                        child: Text(
                          'تغير الصورة',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 16.0),
                        ),
                      ),
                      TextFormField(
                        initialValue: _name,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.pink[900],
                              size: 30,
                            ),
                            labelText: 'الاسم'),
                        validator: (input) => input.trim().length < 1
                            ? 'من فضلك ادخل اسمك'
                            : null,
                        onSaved: (input) => _name = input,
                      ),
                      TextFormField(
                        initialValue: _skills,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.book,
                              color: Colors.pink[900],
                              size: 30,
                            ),
                            labelText: 'المهارات'),
                        validator: (input) => input.trim().length > 150
                            ? 'ادخل مهاراتك'
                            : null,
                        onSaved: (input) => _skills = input,
                      ),
                      TextFormField(
                        initialValue: _address,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.book,
                              color: Colors.pink[900],
                              size: 30,
                            ),
                            labelText: 'العنوان'),
                        validator: (input) => input.trim().length > 150
                            ? 'ادخل عنوانك'
                            : null,
                        onSaved: (input) => _address = input,
                      ),
                      TextFormField(
                        initialValue: _age.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.book,
                              color: Colors.pink[900],
                              size: 30,
                            ),
                            labelText: 'العمر'),
                        validator: (input) => input.trim().length > 150
                            ? 'ادخل عمرك'
                            : null,
                        onSaved: (input) => _age = double.parse(input),
                      ),
                      TextFormField(
                        initialValue: _phone,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.book,
                              color: Colors.pink[900],
                              size: 30,
                            ),
                            labelText: 'رقم التليفون'),
                        validator: (input) => input.trim().length > 150
                            ? 'ادخل رقم تليفونك'
                            : null,
                        onSaved: (input) => _phone = input,
                      ),
                      Container(
                        margin: EdgeInsets.all(50),
                        height: 40.0,
                        width: 250,
                        child: FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: _submit,
                            child: Text(
                              'save Profile',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            )),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
