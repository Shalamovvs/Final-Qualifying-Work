import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forest_island/screens/ListScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto/crypto.dart';

var userUID;

class UserInfo {
  String name;
  String email;
  String id;

  UserInfo({this.id, this.name, this.email});
}

class Category {
  String title;
  Image image;

  Category({this.title, this.image});
}

class MainScreen extends StatefulWidget {
  var userData;
  var tempIndex;

  MainScreen.withUser(final firebaseUser, final _userUID) {
    userData = firebaseUser;
    userUID = _userUID;
  }

  MainScreen();

  @override
  State<StatefulWidget> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends State<MainScreen> {
  List<String> cardNames = [
    'Профиль',
    'Карта магазинов',
    'Новости',
    'Каталог',
  ];

  int tempIndex;
  bool loading = false;

  UserInfo userInfo = UserInfo(id: "", email: "", name: "");
  Category playstation = new Category(
      title: 'Playstation',
      image: Image.network(
          'https://tl-launcher.ru/templates/tllauncher/images/partners/4.png'));

  Category xbox = new Category(
    title: 'XBox',
    image: Image.network('https://pbs.twimg.com/media/DUZqn3wVAAAxLbA.png')
  );

  Category nintendo = new Category(
      title: 'Nintendo',
      image: Image.network('https://tech-bit.ru/upload/iblock/d36/243.png'));

  @override
  void initState() {
    super.initState();
    loading = true;

    http
        .get('https://forestisland.firebaseio.com/user/$userUID.json')
        .then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      loading = false;

      var res = json.decode(response.body) as Map<String, dynamic>;

      setState(() {
        userInfo.name = res["userName"];
        userInfo.email = res["userEmail"];
      });
    }).catchError((error) {
      print("Error: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categoryList = [playstation, xbox, nintendo];

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: Colors.green[600],
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: userInfo.name == ''
                      ? 
                        AutoSizeText('Добро пожаловать!',maxLines: 1, style: new TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white))
                      : 
                        AutoSizeText('${userInfo.name}', maxLines: 1,style: new TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white))
                    ),
                    userInfo.email == null
                      ? 
                        Container()
                      : 
                        AutoSizeText('${userInfo.email}',maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 15)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ListScreen.withInfo(3, userInfo, userUID)));
                        },
                        child: Container(
                          height: 155,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 10),
                          child: CarouselSlider.builder(
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 10),
                              scrollDirection: Axis.horizontal),
                            itemCount: categoryList.length,
                            itemBuilder: (BuildContext context, int index, _){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      AutoSizeText('${categoryList[index].title}', maxLines: 1, style: new TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Image(image: categoryList[index].image.image, height: 100),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        childAspectRatio: 1,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: List.generate(4, (index) {
                          return GestureDetector(
                              onTap: () async {
                                tempIndex = index;
                                final result = await Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => ListScreen.withInfo(tempIndex, userInfo, userUID),settings: RouteSettings(name: '/card')));
                                setState(() {});
                              },
                              child: Container(
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 70,
                                        child: Image.asset(
                                          'assets/images/list_icon$index.png'),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          '${cardNames[index]}',
                                          style: new TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        }),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                        onPressed: () =>
                          Navigator.pushNamed(context, "/contacts"),
                        child: Text('Контакты',style: new TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green[600]))
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
