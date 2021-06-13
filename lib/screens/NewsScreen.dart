import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:forest_island/screens/InnerNewsScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

class News {
  String newsTitle;
  String newsDate;
  Image newsImage;
  String newsText;

  News({this.newsTitle, this.newsDate, this.newsImage, this.newsText});
}

News testNews1 = new News(
  newsTitle: 'MICROSOFT НЕ СОБИРАЕТСЯ ПОВЫШАТЬ ЦЕНЫ НА XBOX SERIES В РОССИИ',
  newsDate: '31.03.2021',
  newsImage: Image.network('https://images.stopgame.ru/news/2021/03/31/c480x270/uuxlr-a_bOMGKOLRg0t1XA/moWMbtB1f.jpg'),
  newsText:'Вчера стало известно, что с 1 апреля Sony повысит стоимость PlayStation 5 для российских магазинов — виной тому падение курса рубля. Последует ли примеру Microsoft? Как выяснило издание PLAYER ONE, отечественные цены на Xbox Series останутся прежними.');

News testNews2 = new News(
  newsTitle: 'ТИРАЖ PS5 ДОСТИГ 7,8 МИЛЛИОНА КОПИЙ — ОН ПРЕВОСХОДИТ ОЖИДАНИЯ SONY',
  newsDate: 'Сегодня',
  newsImage: Image.network('https://images.stopgame.ru/news/2021/04/28/c480x270/w_KOguL8EccDLcjvoYzgMw/iOBrKX_e.jpg'),
  newsText:'Sony опубликовала финансовый отчёт, где рассказала о последних успехах PlayStation. Несмотря на продолжающиеся проблемы с поставками, PS5 ухитряется превышать прогнозы компании.'
);

News testNews3 = new News(
  newsTitle: 'СЕГОДНЯ ВЫХОДИТ GEFORCE RTX 3060 TI — НОВАЯ КОРОЛЕВА СРЕДНЕБЮДЖЕТНЫХ PC',
  newsDate: '02.12.2020',
  newsImage: Image.network('https://images.stopgame.ru/news/2020/12/02/c480x270/jfWX5Zx3xfq93wQU2kqRJg/2CzmpAHv-.jpg'),
  newsText:'Как вы там, не наигрались ещё в «Успей купить видеокарту нового поколения за одну наносекунду»? Сегодня NVIDIA запускает следующий раунд, да ещё и в народном сегменте — в продажу отправляется GeForce RTX 3060 Ti.'
);

News testNews4 = new News(
  newsTitle: 'Sony показала все сильные стороны PlayStation 5 в новом рекламном ролике',
  newsDate: '22.04.2021',
  newsImage: Image.network('https://leonardo.osnova.io/5a542d3f-ad4f-5e90-84db-cb00e0d69244/-/preview/700/-/format/webp/'),
  newsText:'Компания Sony показала новый рекламный ролик, посвящённый консоли нового поколения PlayStation 5 и её сильным сторонам. Среди последних высокая скорость загрузки и большая библиотека игр с PlayStation 4. Также много внимания уделено новому геймпаду DualSense с виброотдачей и адаптивными триггерами. Работа последних наглядно показана в рекламном ролике на примере известных игр. Пользователи продолжают жаловаться на проблемы с поставками PlayStation 5, однако цены на вторичном рынке снизились. Так, в магазинах можно предзаказать консоль за 50 000 рублей, а перекупщики продают её на Avito за 55 000 рублей.'
);

class NewsScreen extends StatelessWidget {

  final controller = ScrollController();
  List<News> newsList = [testNews1, testNews2, testNews3, testNews4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new ListView.builder(
            shrinkWrap: true,
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: InnerNewsScreen(
                        newsList[index].newsTitle,
                        newsList[index].newsImage,
                        newsList[index].newsText
                      )
                    )
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            // ! Если будут проблемы с фотками height: MediaQuery.of(context).size.height * 1 / 6,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image(
                                  image: newsList[index].newsImage.image,
                                  // ! Если будут проблемы с фотками fit: BoxFit.fitWidth
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: AutoSizeText(newsList[index].newsTitle,
                                    maxLines: 3,
                                    textAlign: TextAlign.left,
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                                ),
                              ),
                              Icon(Icons.arrow_forward,
                                  color: Colors.green[400])
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(newsList[index].newsDate,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: new TextStyle(
                                    color: Colors.grey, fontSize: 9)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
