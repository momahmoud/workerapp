import 'package:flutter/material.dart';

class searchFiled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(

        margin: EdgeInsets.only(top: 20.0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(25.0),
          child: TextField(

            decoration: InputDecoration(
                hintText: "ابحث عن عامل",
                suffixIcon: Material(
                  elevation: 5.0,

                  borderRadius: BorderRadius.circular(25.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                border: InputBorder.none,
                 contentPadding:
                 EdgeInsets.symmetric(horizontal: 32, vertical: 14.0)
     ),
          ),
        ),
      ),
    );
  }
}
