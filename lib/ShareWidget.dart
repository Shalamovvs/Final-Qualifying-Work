import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';

void main() => runApp(ShareWidget());

class ShareWidget extends StatelessWidget {
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example',
        text: 'Тестовый текст',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Проверка');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: Material(
                  color: Colors.blue, // button color
                  child: InkWell(
                    splashColor: Colors.red, // inkwell color
                    child: SizedBox(width: 56, height: 56, child: Icon(Icons.share, color: Colors.white,)),
                    onTap: share,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
