import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workerapp/Maseege/Maseege_page.dart';
import 'package:workerapp/addDataAndSkills/addData.dart';
import 'package:workerapp/models/user_model.dart';

import 'package:workerapp/home/Home.dart';
import 'package:workerapp/profil/ProfilePage.dart';
import 'package:workerapp/utils/constant.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserModel currentUser;
  Home  homePage;
  Mseege   mseege;
  AddData  addData;
  ProfilePage profilePage;
  List<Widget> pages;
  Widget curentPages ;
  int CruntTapIndex =0;
  bool isLoading =false;
   getProfilePosts() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await postsRef
        .document(currentUser.id)
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

  @override
  void initState() {
    getProfilePosts();
    super.initState();
    homePage=Home();
    mseege=Mseege();

    profilePage=ProfilePage(userId: currentUser?.id,);
    addData=AddData();
    pages=[homePage,mseege,profilePage,addData];
    curentPages=homePage;
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index){
            setState(() {
              CruntTapIndex=index;
              curentPages=pages[index];
            });
          },
          currentIndex: CruntTapIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home) ,
                title: Text("الرئيسيه")
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.message) ,
                title: Text("الرسائل")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person) ,
                title: Text("الشخصيه")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add) ,
                title: Text("اضافة عامل")
            ),
          ],
        ),
        body: curentPages,

      ),
    );
  }
}
