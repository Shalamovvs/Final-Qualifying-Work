import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class GreettingsScreen extends StatelessWidget {
  const GreettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(''),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: AutoSizeText('Доброе утро,\n Сергей!',textAlign: TextAlign.center ,maxLines: 2, style: new TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}