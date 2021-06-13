import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class InnerNewsScreen extends StatelessWidget {
  final controller = ScrollController();

  var newsTitle;
  var newsImage;
  var newsText;

  InnerNewsScreen(title, image, text){
    newsTitle = title;
    newsImage = image;
    newsText = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        materialType: MaterialType.transparency,
        controller: controller,
        leading: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 40,
              maxWidth: 40
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_outlined, 
                  color: Colors.green[400],
                  size: 17
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        // title: Padding(
        //   padding: const EdgeInsets.only(top: 10),
        //   child: AutoSizeText("$newsTitle", style: new TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16), maxLines: 2)
        // ),
        title: AutoSizeText("$newsTitle", style: new TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16), maxLines: 2),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: newsImage.image,
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(newsText, style: new TextStyle(fontSize: 14, height: 2)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}