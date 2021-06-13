import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              color: Colors.green[600],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.gamepad_outlined, size: 80, color: Colors.white),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText('EShop', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                      AutoSizeText('Start New Game', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 17))
                    ],
                  )
                ],
              )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  width: 50,
                  height: 50,
                  child: ButtonSheet(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      child: Icon(Icons.login, color: Colors.green[600]),
      onPressed: () {
        showBottomSheet(
            context: context,
            builder: (context) => Container(
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          'Добро пожаловать',
                          style: new TextStyle(
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 13),
                        child: AutoSizeText(
                          'Интернет каталог \n для покупателей магазина EShop',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: new TextStyle(fontSize: 15, height: 1),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: RaisedButton(
                            color: Colors.green[600],
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () =>
                                Navigator.pushNamed(context, "/authWrapper"),
                            child: AutoSizeText(
                              'Войти',
                              maxLines: 1,
                              style: new TextStyle(
                                  fontSize: 18, color: Colors.white),
                            )),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 7),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/registration");
                            },
                            child: Text(
                              'Нет аккаунта? Зарегистрируйтесь',
                              style: new TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                    ],
                  ),
                ));
      },
    );
  }
}
