import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Связаться с нами',
                style: new TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GestureDetector(
                    onTap: () => launch("tel://+7 351 242 0232"),
                    child: Text(
                      'Отдел продаж \n +7 (351) 242-02-32',
                      style: new TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GestureDetector(
                    onTap: () => launch("tel://73517788001"),
                    child: Text(
                      'Управляющая компания \n +7 (351) 778-80-01',
                      style: new TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GestureDetector(
                    onTap: () => {launch('https://www.lesnoyostrov.ru/')},
                    child: Text(
                      'lesnoyostrov.ru',
                      style: new TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: GestureDetector(
                    onTap: () => {launch('https://www.xpage.ru/')},
                    child: Text(
                      'Developed by \n XPage',
                      style: new TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
