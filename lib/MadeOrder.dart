import 'package:auto_size_text/auto_size_text.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:flutter/material.dart';

class MadeOrder extends StatelessWidget {

final controller = ScrollController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller,
        materialType: MaterialType.transparency,
        leading: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 30,
              maxWidth: 30
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
                  color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
                  size: 14
                ),
                onPressed: () {

                },
              ),
            ),
          ),
        ),
        backgroundColor: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
      ),
      body: Container(
        color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    child: Container(
                      child: Image.asset('assets/images/greetings_logo.png')
                    ),
                  ),
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
                        color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
                        child: AutoSizeText('Понятно', maxLines: 1, style: new TextStyle(fontSize: 14, color: Colors.white)),
                        onPressed: () {

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
    );
  }
}