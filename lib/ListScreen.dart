import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forest_island/PhotoScreen.dart';
import 'package:forest_island/SitesInfoScreen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

int _selectedIndex;
dynamic userInfo;
dynamic userUID;

var url = 'https://forestisland.firebaseio.com/user/${userUID}.json';

List<String> searchHeader = <String>[
  'Отчет Эксплуатационной компании Лесной остров за 2019 год',
  'Отчет Эксплуатационной компании Лесной остров за 2019 год',
  'Отчет Эксплуатационной компании Лесной остров за 2019 год'
];

List<String> searchText = <String>[
  'Отчет о расходовании средств и исполнении бюджета, расходовании средств Инвестиционного фонда...',
  'Отчет о расходовании средств и исполнении бюджета, расходовании средств Инвестиционного фонда...',
  'Отчет о расходовании средств и исполнении бюджета, расходовании средств Инвестиционного фонда...'
];

final TextEditingController nameController = TextEditingController();
final TextEditingController carTypeController = TextEditingController();
final TextEditingController carNumberController = TextEditingController();

final TextEditingController userNameController = TextEditingController();
final TextEditingController userAddressController = TextEditingController();
final TextEditingController searchController = TextEditingController();

class ListScreen extends StatefulWidget {
  ListScreen() {}

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
    'Публикации',
    'Охрана',
    'Голосование',
    'Галерея',
    'Вакансии'
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
                  controller: userAddressController,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_city),
                    hintText: 'Адрес пользователя',
                    contentPadding: EdgeInsets.all(5),
                  ),
                ),
              ),
            ),
            Container(
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Save',
                  style: new TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  if (userNameController.text != '' &&
                      userAddressController.text != '') {
                    userInfo.name = userNameController.text;
                    userInfo.address = userAddressController.text;

                    var response = await http.patch(
                      url,
                      body: json.encode({
                        'userName': userInfo.name,
                        'userAddress': userInfo.address,
                      }),
                    );
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');

                    Get.dialog(SimpleDialog(
                      contentPadding: EdgeInsets.all(8),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'Данные сохранены',
                                style: new TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'FiraSans',
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              ),
                            ],
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
                          child: Column(
                            children: [
                              Text(
                                'Заполните все поля',
                                style: new TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'FiraSans',
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                              ),
                            ],
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
    Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 40,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.all(5),
                    hintText: 'Search',
                  ),
                ),
              ),
            ),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: searchHeader.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '${searchHeader[index]}',
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                  const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1))),
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      '${searchText[index]}',
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    ),
    Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30),
              width: 300,
              height: 40,
              child: TextField(
                style: new TextStyle(fontSize: 12, fontFamily: 'Loto'),
                controller: nameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                    hintText: 'Имя'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 300,
              height: 40,
              child: TextField(
                controller: carTypeController,
                style: new TextStyle(fontSize: 12, fontFamily: 'Loto'),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                    hintText: 'Марка машины'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 300,
              height: 40,
              child: TextField(
                controller: carNumberController,
                style: new TextStyle(fontSize: 12, fontFamily: 'Loto'),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                    hintText: 'Номер машины'),
              ),
            ),
            Container(
              width: 300,
              margin: EdgeInsets.only(top: 10),
              child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                  onPressed: () => {
                        if (nameController.text != '' &&
                            carTypeController.text != '' &&
                            carNumberController.text != '')
                          {
                            Get.dialog(SimpleDialog(
                              contentPadding: EdgeInsets.all(8),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Заявка отправлена',
                                        style: new TextStyle(
                                          fontSize: 30,
                                          fontFamily: 'FiraSans'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                          }
                        else
                          {
                            Get.dialog(SimpleDialog(
                              title: Text(
                                'Error',
                                style: new TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'FiraSans'),
                              ),
                              contentPadding: EdgeInsets.all(8),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Заполните все поля',
                                        style: new TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'FiraSans'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ))
                          }
                      },
                  child: Text(
                    'Send',
                    style: new TextStyle(
                      fontSize: 18,
                    ),
                  )
                ),
            ),
          ],
        ),
      ),
    ),
    Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Отдайте свой голос', style: new TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
        ],
      ),
    ),
    Scaffold(
      body: PhotoScreen()
    ),
    Scaffold(
      body: SitesInfoScreen()
    ),
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
          leadingWidth: 80,
          toolbarHeight: 30,
          centerTitle: true,
          leading: Navigator.canPop(context)
            ? GestureDetector(
                child: FlatButton
                (
                  onPressed: null,
                  child: Text(
                    'Back',
                    style: new TextStyle(fontSize: 14),
                  )
                ),
                onTap: () {
                  Navigator.of(context).pop(userInfo);
                  return Future.value(false);
                },
              )
            : null,
          title: Text(
            '${labelScreens[_selectedIndex]}',
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 15,
              fontFamily: 'FiraSans',
            ),
          ),
          actions: [
            FlatButton(
                onPressed: null,
                child: Text('Edit', style: new TextStyle(fontSize: 14))),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Профиль',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: 'Публикации',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.security),
              label: 'Охрана',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Голосование'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_album),
              label: 'Галерея',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Вакансии',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedLabelStyle: new TextStyle(fontSize: 8),
          unselectedLabelStyle: new TextStyle(fontSize: 8),
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
