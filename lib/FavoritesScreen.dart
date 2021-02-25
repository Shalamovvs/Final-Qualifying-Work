import 'package:auto_size_text/auto_size_text.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoritesScreen extends StatelessWidget {

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
        backgroundColor: Colors.white,
        centerTitle: true,
        title: AutoSizeText("Избранное", style: new TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18), maxLines: 1),
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
                      child: SvgPicture.asset("assets/images/empty_favorites.svg")
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: AutoSizeText('В избранном пусто',maxLines: 1, textAlign: TextAlign.center, style: new TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: AutoSizeText('Добавляйте товары в избранное \n из карточки товара, чтобы они \n всегда были под рукой',textAlign: TextAlign.center,maxLines: 3, style: new TextStyle(fontSize: 14)),
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