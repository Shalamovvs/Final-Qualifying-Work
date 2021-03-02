import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LostInternetScreen extends StatelessWidget {

final controller = ScrollController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50, top: 8, left: 6, right: 8),
                    child: Container(
                      child: SvgPicture.asset("assets/images/lost_internet.svg")
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: AutoSizeText('Интернет отсутствует',maxLines: 1, textAlign: TextAlign.center, style: new TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: AutoSizeText('Как только интернет появится \n мы сразу покажем наш каталог',textAlign: TextAlign.center,maxLines: 2, style: new TextStyle(fontSize: 14)),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 23),
              child: Container(
                width: MediaQuery.of(context).size.width * 3 / 4,
                height: 50,
                child: RaisedButton(
                  color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
                  onPressed: () {
                    
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: AutoSizeText('Попробовать ещё', style: new TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
