import 'package:flutter/material.dart';
import 'package:workerapp/Maseege/Maseege_page.dart';


import 'package:workerapp/home/Home.dart';
import 'package:workerapp/profil/ProfilePage.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Home  homePage;
  Mseege   mseege;

  ProfilePage profilePage;
  List<Widget> pages;
  Widget curentPages ;
  int CruntTapIndex =0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePage=Home();
    mseege=Mseege();

    profilePage=ProfilePage();
    pages=[homePage,mseege,profilePage];
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
          ],
        ),
        body: curentPages,

      ),
    );
  }
}
