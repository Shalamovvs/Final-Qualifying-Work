import 'package:auto_size_text/auto_size_text.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartScreen extends StatelessWidget {

final controller = ScrollController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        materialType: MaterialType.transparency,
        controller: controller,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
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
                    Icons.favorite, 
                    color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
                    size: 17
                  ),
                  onPressed: () {

                  },
                ),
              ),
            ),
        ),
          ),
        ],
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
                  color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
                  size: 17
                ),
                onPressed: () {

                },
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: AutoSizeText("Моя корзина", style: new TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18), maxLines: 1),
      ),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child:  SvgPicture.asset("assets/images/empty_cart.svg")
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: AutoSizeText('В корзине пока пусто',maxLines: 1, textAlign: TextAlign.center, style: new TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: AutoSizeText('Добавленные товары \n будут отображаться тут',textAlign: TextAlign.center,maxLines: 2, style: new TextStyle(fontSize: 14)),
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
                    child: AutoSizeText('Перейти к покупкам', style: new TextStyle(color: Colors.white, fontSize: 16)),
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