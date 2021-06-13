import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:forest_island/screens/CartScreen.dart';
import 'package:forest_island/screens/CatalogScreen.dart';
import 'package:forest_island/screens/NewsScreen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'MapWidgetRav.dart';

int _selectedIndex;
dynamic userInfo;
dynamic userUID;

var url = 'https://forestisland.firebaseio.com/user/${userUID}.json';

final TextEditingController nameController = TextEditingController();
final TextEditingController carTypeController = TextEditingController();
final TextEditingController carNumberController = TextEditingController();

final TextEditingController userNameController = TextEditingController();
final TextEditingController userEmailController = TextEditingController();
final TextEditingController searchController = TextEditingController();

class ListScreen extends StatefulWidget {
  ListScreen();

  ListScreen.withInfo(int tempIndex, var _userInfo, dynamic _userUID) {
    _selectedIndex = tempIndex;
    userInfo = _userInfo;
    userUID = _userUID;
  }

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String> labelScreens = [
    'Профиль',
    'Карта',
    'Новости',
    'Каталог',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions = <Widget>[
    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 40,
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                    prefixIcon: Icon(Icons.supervised_user_circle),
                    hintText: 'Имя пользователя',
                    contentPadding: EdgeInsets.all(5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 40,
                child: TextField(
                  controller: userEmailController,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: 'Email пользователя',
                    contentPadding: EdgeInsets.all(5),
                  ),
                ),
              ),
            ),
            Container(
              child: RaisedButton(
                color: Colors.green[400],
                child: Text(
                  'Сохранить',
                  style: new TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onPressed: () async {
                  if (userNameController.text != '' &&
                      userEmailController.text != '') {
                    userInfo.name = userNameController.text;
                    userInfo.email = userEmailController.text;

                    var response = await http.patch(
                      url,
                      body: json.encode({
                        'userName': userInfo.name,
                        'userEmail': userInfo.email,
                      }),
                    );
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');

                    Get.dialog(SimpleDialog(
                      contentPadding: EdgeInsets.all(8),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            'Данные сохранены',
                            maxLines: 1,
                            style: new TextStyle(
                              fontSize: 30,
                              fontFamily: 'FiraSans',
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ));
                  } else {
                    Get.dialog(SimpleDialog(
                      contentPadding: EdgeInsets.all(8),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            'Заполните все поля',
                            maxLines: 1,
                            style: new TextStyle(
                              fontSize: 30,
                              fontFamily: 'FiraSans',
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ));
                  }
                },
              ),
            )
          ],
        ),
      ),
    ),
    MapWidgetRav(),
    NewsScreen(),
    HomeScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(userInfo);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          leadingWidth: 80,
          toolbarHeight: 50,
          centerTitle: true,
          leading: FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            child: AutoSizeText('Назад', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 16)),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
              }, 
              child: AutoSizeText('Корзина', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 16)),
            )
          ],
          title: AutoSizeText('${labelScreens[_selectedIndex]}', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30),
              label: 'Профиль',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store_mall_directory_outlined, size: 30),
              label: 'Карта',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_rounded, size: 30),
              label: 'Новости',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, size: 30), 
              label: 'Каталог'
            ),
          ],
          selectedItemColor: Colors.green[400],
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedLabelStyle: new TextStyle(fontSize: 10),
          unselectedLabelStyle: new TextStyle(fontSize: 10),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
