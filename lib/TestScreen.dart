import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:forest_island/CartScreen.dart';
import 'package:forest_island/CatalogScreen.dart';
import 'package:forest_island/FavoritesScreen.dart';
import 'package:forest_island/GreetingsScreen.dart';
import 'package:forest_island/LoadingScreen.dart';
import 'package:forest_island/MapWidgetRav.dart';
import 'package:forest_island/OrderHistory.dart';
import 'package:forest_island/RavRegistrationScreen.dart';
import 'package:forest_island/RegistrationScreen.dart';
import 'package:forest_island/SearchScreen.dart';
import 'package:page_transition/page_transition.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push( context, PageTransition( type: PageTransitionType.fade, child: LoadingScreen()));
                  },
                  child: AutoSizeText('Экран загрузки')
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: RavRegistationScreen()));
                  },
                  child: AutoSizeText('Регистрация')
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: GreettingsScreen()));
                  },
                  child: AutoSizeText('Приветствие')
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: MapWidgetRav()));
                  },
                  child: AutoSizeText('Карта')
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: CatalogScreen()));
                  },
                  child: AutoSizeText('Каталог (еще в работе)')
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: FavoritesScreen()));
                  },
                  child: AutoSizeText('Пустой экран избранное')
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: OrderHistory()));
                  },
                  child: AutoSizeText('Пустой экран заказов')
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: CartScreen()));
                  },
                  child: AutoSizeText('Пустая корзина')
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: SearchScreen()));
                  },
                  child: AutoSizeText('Поиск')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}