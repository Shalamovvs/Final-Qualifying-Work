import 'package:flutter/material.dart';
import 'package:forest_island/ListScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

var userUID;

class UserInfo {
  String name;
  String address;
  String id;

  UserInfo({this.id, this.name, this.address});
}
class PersonalScreen extends StatefulWidget {
  var userData;
  var tempIndex;

  PersonalScreen.withUser(final firebaseUser, final _userUID) {
    userData = firebaseUser;
    userUID = _userUID;
  }

  PersonalScreen();

  @override
  State<StatefulWidget> createState() {
    return _PersonalScreen();
  }
}

class _PersonalScreen extends State<PersonalScreen> {
  List<String> cardNames = [
    'Профиль',
    'Публикации',
    'Отправить заявку на охрану',
    'Голосование',
    'Галерея',
    'Вакансии'
  ];

  var tempIndex;
  var loading = false;
  UserInfo userInfo = UserInfo(id: "", address: "", name: "");

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
        userInfo.address = res["userAddress"];
      });
    }).catchError((error) {
      print("Error: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    print(userUID);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(child: Builder(builder: (context) {
                    if (loading) {
                      return CircularProgressIndicator();
                    } else {
                      return Text(
                        '${userInfo.name}',
                        style: new TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  })),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        '${userInfo.address}',
                        style: new TextStyle(
                          fontSize: 11,
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Image.asset('assets/images/banner_1.jpg'),
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
                      children: List.generate(6, (index) {
                        return GestureDetector(
                            onTap: () async {
                              tempIndex = index;
                              // ignore: unused_local_variable
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListScreen.withInfo(
                                      tempIndex, userInfo, userUID),
                                    settings: RouteSettings(name: '/card')));
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () =>
                            Navigator.pushNamed(context, "/contacts"),
                        child: Text(
                          'Contacts',
                          style: new TextStyle(
                            fontSize: 18,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
