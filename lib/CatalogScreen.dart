import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:forest_island/widgets/CatalogWidget.dart';
import 'package:forest_island/widgets/CategoryWidget.dart';
import 'package:forest_island/widgets/SearchFieldWidget.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Category {
  String categoryTitle;
  String categoryColor;
  Image categoryImage;
  List<String> categoryProduct;

  Category({
    this.categoryTitle,
    this.categoryColor,
    this.categoryImage,
    this.categoryProduct
  });
}

Category testCategory1 = new Category(
  categoryTitle: 'Дубрава',
  categoryColor: '#FEF6ED',
  categoryImage: Image.network('https://spkfood.ru/upload/iblock/11d/11d3b9b58b1ab3484a08fd4c267c32b6.png'),
  categoryProduct: ['Ветчины', 'Изделия мясные в желе, паштеты, консервы', 'Колбасы варёные', 'Колбасы копчёные сосиски, сардельки, шпикачки']
);

Category testCategory2 = new Category(
  categoryTitle: 'Готовая продукция',
  categoryColor: '#FDE8E4',
  categoryImage: Image.network('https://productovich.ru/upload/iblock/927/9271d016cffd7c2213dc29004fef4983.png'),
  categoryProduct: ['Ветчины', 'Изделия мясные в желе, паштеты, консервы', 'Колбасы варёные', 'Колбасы копчёные сосиски, сардельки, шпикачки']
);

Category testCategory3 = new Category(
  categoryTitle: 'Мясо птицы',
  categoryColor: '#F4EBF7',
  categoryImage: Image.network('https://keto-recipes.ru/wp-content/uploads/2018/05/chicken.png'),
  categoryProduct: ['Ветчины', 'Изделия мясные в желе, паштеты, консервы', 'Колбасы варёные', 'Колбасы копчёные сосиски, сардельки, шпикачки']
);

class CatalogScreen extends StatelessWidget {

  final controller = ScrollController(); 

  @override
  Widget build(BuildContext context) {
    List<Category> categoryList = [testCategory1,testCategory2,testCategory3,testCategory2,testCategory3,testCategory2,testCategory1,testCategory3,testCategory2,testCategory1];
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
        title: AutoSizeText("Каталог", style: new TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18), maxLines: 1),
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
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width:  MediaQuery.of(context).size.width,
                  child: CategoryWidget(categoryList)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}