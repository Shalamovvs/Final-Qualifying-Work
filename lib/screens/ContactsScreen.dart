import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        leadingWidth: 80,
        toolbarHeight: 30,
        centerTitle: true,
        title: AutoSizeText('Контакты', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        leading: FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          child: AutoSizeText('Назад', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 14)),
        )
      ),
      backgroundColor: Colors.green[600],
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AutoSizeText('Связаться с нами', maxLines: 1, style: new TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
              
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GestureDetector(
                  onTap: () => launch("tel://+7 351 242 0232"),
                  child: AutoSizeText('Отдел продаж\n+7 (351) 242-02-32', maxLines: 2,textAlign: TextAlign.center ,style: new TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GestureDetector(
                  onTap: () => launch("tel://73517788001"),
                  child: AutoSizeText('Управляющая компания\n+7 (351) 778-80-01', maxLines: 2,textAlign: TextAlign.center ,style: new TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GestureDetector(
                  onTap: () => {launch('https://www.google.com/')},
                  child: AutoSizeText('EShop.ru', maxLines: 2,textAlign: TextAlign.center ,style: new TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: GestureDetector(
                  onTap: () => {launch('https://github.com/Shalamovvs')},
                  child: AutoSizeText('Developed by\n vshlmv', maxLines: 2,textAlign: TextAlign.center ,style: new TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
