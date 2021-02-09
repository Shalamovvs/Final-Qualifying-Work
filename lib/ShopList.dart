import 'package:flutter/material.dart';
import 'package:forest_island/MapBloc.dart';
import 'package:forest_island/MapWidget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as YMaps;
import 'package:url_launcher/url_launcher.dart';
import 'package:rxdart/rxdart.dart';

abstract class MapPage extends StatelessWidget {
  const MapPage(this.title);

  final String title;
}

class ControlButton extends StatelessWidget {
  const ControlButton({Key key, @required this.onPressed, @required this.title})
      : super(key: key);

  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: RaisedButton(
        child: Text(title, textAlign: TextAlign.center),
        onPressed: onPressed
      ),
    );
  }
}

class ShopList extends StatelessWidget {
  final List<Shop> shopList;
  final YMaps.YandexMapController controller;
  ShopList({Key key, @required this.shopList, this.controller}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: shopList.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.orange[700],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                      title: Text(shopList[i].shopAddress,
                          style: new TextStyle(fontSize: 18)),
                      subtitle: Text(
                          '${shopList[i].shopStartTime} - ${shopList[i].shopEndTime}',
                          style: new TextStyle(fontSize: 18)),
                      trailing: FlatButton(
                          onPressed: () {
                            Navigator.pop(context,MaterialPageRoute(builder: (context) => MapWidget()));
                            controller.move(point: YMaps.Point(latitude: shopList[i].shopPosition.latitude,longitude:shopList[i].shopPosition.longitude));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(color: Colors.orange[800])),
                          disabledTextColor: Colors.orange[800],
                          disabledColor: Colors.white,
                          child: Text('Показать на карте'))),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

