import 'package:flutter/material.dart';
import 'package:forest_island/widgets/CatalogScrollWidget.dart';
import 'package:forest_island/widgets/CatalogWidget.dart';
import 'package:forest_island/widgets/SearchFieldWidget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class SectionScroll {
  String sectionTitle;
  List<Image> itemImage;
  List<String> itemName;
  List<int> itemPrice;
  List<String> promotionTitle;
  List<String> oldPrice;

  SectionScroll({
    this.sectionTitle,
    this.itemImage,
    this.itemName,
    this.itemPrice,
    this.promotionTitle,
    this.oldPrice
  });
}

SectionScroll testSection1 = new SectionScroll(
  sectionTitle: 'Новинки',
  itemImage: [Image.network('https://im0-tub-ru.yandex.net/i?id=4259787c79e9a0da7a5e1dfc0d00d488&n=13'), Image.network('https://im0-tub-ru.yandex.net/i?id=ed57bec0eaefda6fffa711dff0d7d6e8&n=13')],
  itemName: ['Филе куриное', 'Сосиски Дубровские'],
  itemPrice: [200, 250],
  promotionTitle: ['Новинка', null],
  oldPrice: [null, '300']
);

SectionScroll testSection2 = new SectionScroll(
  sectionTitle: 'Лучшее предложение',
  itemImage: [Image.network('https://croc29.ru/image/cache/catalog/fastfood/BLINI_S_VETCHINOJ_I_SIROM00[1]-900x900.png'), Image.network('https://im0-tub-ru.yandex.net/i?id=406880246cbe47c2c686bb37160fa07a&n=13'), Image.network('https://im0-tub-ru.yandex.net/i?id=ab0c6e6c9fc4003e1f345289529a3bea&n=13')],
  itemName: ['Блинчики с курицей', 'Блинчики с творогом', 'Блинчики с творогом'],
  itemPrice: [200, 300 , 200],
  promotionTitle: [null,'13%', null],
  oldPrice: [null, '350', null]
);

class HomeScreen extends StatelessWidget {

  final controller = ScrollController(); 

  @override
  Widget build(BuildContext context) {
    List<SectionScroll> sectionList = [testSection1, testSection2 , testSection2];
    return Scaffold(
      appBar: ScrollAppBar(
        materialType: MaterialType.transparency,
        controller: controller,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  Icons.store, 
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
        title: AutoSizeText("Лесопарковая 8", style: new TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18), maxLines: 1),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  child: SearchFieldWidget(Color(int.parse('#F5F5F6'.replaceAll('#', '0xff')))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  color: Colors.white,
                  width:  MediaQuery.of(context).size.width,
                  child: CatalogWidget()
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  width:  MediaQuery.of(context).size.width,
                  child: CatalogScrollWidget(sectionList)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}