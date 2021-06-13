import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:forest_island/screens/MainScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:flutter/material.dart';

class MadeOrder extends StatelessWidget {

final controller = ScrollController(); 

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
        child: Scaffold(
        backgroundColor: Colors.green[400],
        body: Container(
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
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: AutoSizeText('Ваш заказ № 256 \n успешно оформлен',maxLines: 2, textAlign: TextAlign.center, style: new TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: AutoSizeText('Ваш заказ будет собран в 16:30',textAlign: TextAlign.center,maxLines: 1, style: new TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                      child: Container(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Colors.white)
                          ),
                          color: Colors.green[400],
                          child: AutoSizeText('Понятно', maxLines: 1, style: new TextStyle(fontSize: 14, color: Colors.white)),
                          onPressed: () {
                            Navigator.push(context, PageTransition(type: PageTransitionType.fade,child: MainScreen()));
                          }
                        )
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 23),
                child: GestureDetector(
                  onTap: () {
                    
                  },
                  child: Container(
                    child: AutoSizeText('Поделиться заказом', maxLines: 1, style: new TextStyle(fontSize: 12, decoration: TextDecoration.underline, color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}