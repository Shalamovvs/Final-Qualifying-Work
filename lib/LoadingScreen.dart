import 'package:flutter/material.dart';
import 'package:flutter_animation_set/widget/transition_animations.dart';
import 'package:flutter_animation_set/widget/behavior_animations.dart';

class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool run = true;
    return Scaffold(
      body: Container(
        color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Image.asset('assets/images/greetings_logo.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Container(
                  child: Image.asset('assets/images/rav-text-logo.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: Container(
                  child: YYThreeBounce(),
                ),
              )
            ]
          ),
        )
      ),
    );
  }
}