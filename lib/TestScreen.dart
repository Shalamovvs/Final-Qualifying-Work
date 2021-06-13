import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:forest_island/screens/CatalogScreen.dart';
import 'package:forest_island/screens/CatalogScreen.dart';
import 'package:forest_island/screens/MapWidgetRav.dart';
import 'package:page_transition/page_transition.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YandexMap(),
    );
  }
}