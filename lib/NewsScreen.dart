import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class News{
  List<String> newsTitle;
  List<String> newsDate;
  List<Image> newsImage;

  News({
    this.newsTitle,
    this.newsDate,
    this.newsImage,
  });
}

News testNews1 = new News(
  newsTitle: ['Комфортные улучшенные условия труда', 'Вы понимаете, как зарабатывать больше'],
  newsDate: ['01.01.2021' , '02.02.2021'],
  newsImage: [Image.network('https://ravisagro.ru/upload/iblock/6dc/6dc8e69e6ffafbc5ce393c80dfff6763.jpg'), Image.network('https://ravisagro.ru/upload/iblock/3d3/3d38ea1025b313af6897576bd6f39769.JPG')],
);

class NewsScreen extends StatelessWidget {

  final controller = ScrollController(); 

  @override
  Widget build(BuildContext context) {
    List<News> newsList = [testNews1, testNews1];
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
        title: AutoSizeText("Новости", style: new TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18), maxLines: 1),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new ListView.builder(
          shrinkWrap: true,
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1 / 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: newsList[index].newsImage[index].image,
                          fit: BoxFit.fitWidth
                        ),
                      )
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: AutoSizeText(newsList[index].newsTitle[index],maxLines: 2 ,textAlign: TextAlign.left, style: new TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}