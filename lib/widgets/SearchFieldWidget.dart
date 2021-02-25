import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {
  
  SearchFieldWidget(backGroundColor)
  {
    this.backGroundColor = backGroundColor;
  }

  var backGroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backGroundColor,
      child: TextField(
        decoration: new InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 3.0),
          ),
          prefixIcon: Icon(Icons.search, color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff')))),
          contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
          hintText: "Поиск"
        ),
      ),
    );
  }
}