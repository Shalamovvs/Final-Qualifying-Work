import 'package:flutter/material.dart';
import 'package:forest_island/MapBloc.dart';
import 'package:forest_island/ShopList.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
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
          onPressed: onPressed),
    );
  }
}

class Shop {
  String shopName;
  String shopAddress;
  YMaps.Point shopPosition;
  String shopStartTime;
  String shopEndTime;

  Shop(
      {this.shopName,
      this.shopAddress,
      this.shopStartTime,
      this.shopEndTime,
      this.shopPosition});
}

class MapWidget extends StatelessWidget {
  MapBloc _mapBloc = new MapBloc(
      shop: ShopInfo(),
      userPosition: Position(latitude: 55.753215, longitude: 37.622504));
  YMaps.YandexMapController controller;

  @override
  Widget build(BuildContext context) {
    Shop testShop = new Shop(
      shopAddress: 'Ул Кирова 4',
      shopPosition: YMaps.Point(latitude: 55.164639, longitude: 61.401215),
      shopStartTime: '09:00',
      shopEndTime: '20:00',
    );

    Shop testShop2 = new Shop(
      shopAddress: 'Ул Кирова 6',
      shopPosition: YMaps.Point(latitude: 57.164639, longitude: 62.401215),
      shopStartTime: '10:00',
      shopEndTime: '19:00',
    );

    List<Shop> shopList = [testShop, testShop2];
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Expanded(
                      child: FutureBuilder(
                      future: _mapBloc.getMarker(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          return Container();

                        var tmpSnapData = snapshot.data;
                        var userSnapData;
                        var shopSnapData;

                        return StreamBuilder(
                          stream: Observable.combineLatest2(
                            _mapBloc.subjectShopObservable,
                            _mapBloc.subjectUserPosObservable, (b1, b2) {
                            userSnapData = b2;
                            shopSnapData = b1;
                          }),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            List<YMaps.Placemark> placemarkArray = [
                              YMaps.Placemark(
                                point: const YMaps.Point(latitude: 55.15402, longitude: 61.42915),
                                onTap: (YMaps.Point point) {
                                  _mapBloc.updateLocation();
                                  _mapBloc.distanceCount(
                                    userSnapData.latitude,
                                    userSnapData.longitude,
                                    point.latitude,
                                    point.longitude);

                                  _presentBottomSheet(context);
                                },
                                style: YMaps.PlacemarkStyle(
                                  opacity: 0.95,
                                  zIndex: 1,
                                  scale: 0.2,
                                  rawImageData:tmpSnapData.buffer.asUint8List()),
                              ),
                              YMaps.Placemark(
                                point: const YMaps.Point(latitude: 55.164639, longitude: 61.401215),
                                onTap: (YMaps.Point point) {
                                  _mapBloc.updateLocation();
                                  _mapBloc.distanceCount(
                                    userSnapData.latitude,
                                    userSnapData.longitude,
                                    point.latitude,
                                    point.longitude);

                                  _presentBottomSheet(context);
                                },
                                style: YMaps.PlacemarkStyle(
                                  opacity: 0.95,
                                  zIndex: 2,
                                  scale: 0.2,
                                  rawImageData:tmpSnapData.buffer.asUint8List()
                                ),
                              )
                            ];

                            return new Stack(
                              children: <Widget>[
                                YMaps.YandexMap(
                                  onMapCreated: (YMaps.YandexMapController yandexMapController) async {
                                    controller = yandexMapController;
                                    controller.toggleNightMode(enabled: true);
                                    controller.move(
                                      zoom: 12,
                                      animation: YMaps.MapAnimation(),
                                      point: const YMaps.Point(latitude: 55.164639,longitude: 61.401215));
                                  },
                                  onMapRendered: () {
                                    _mapBloc.checkPermission();
                                    _mapBloc.updateLocation();
                                    placemarkArray.forEach((element) {
                                      controller.addPlacemark(element);
                                    });
                                  },
                                ),
                                StreamBuilder(
                                    stream: _mapBloc.subjectUserPosObservable,
                                    builder: (context, snapshot) {
                                      var tmpSnapShot = snapshot.data;
                                      return Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          height: 50,
                                          width: 40,
                                          child: Column(
                                            children: <Widget>[
                                              FutureBuilder(
                                                  future:_mapBloc.getUserMarker(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.connectionState !=
                                                        ConnectionState.done)
                                                      return Container();

                                                    return IconButton(
                                                        icon: Icon(Icons.navigation_outlined),
                                                        onPressed: () {
                                                          _mapBloc.updateLocation();
                                                          YMaps.Point userLocation =YMaps.Point(latitude:tmpSnapShot.latitude,longitude:tmpSnapShot.longitude);
                                                          var userPlacemark =
                                                            YMaps.Placemark(
                                                              point: userLocation,
                                                              style: YMaps.PlacemarkStyle(
                                                                opacity: 0.95,
                                                                zIndex: 1,
                                                                scale: 0.1,
                                                                rawImageData:snapshot.data.buffer.asUint8List()
                                                              ),
                                                            );
                                                          controller.addPlacemark(userPlacemark);
                                                          controller.move(
                                                              zoom: 12,
                                                              animation: YMaps.MapAnimation(),
                                                              point:userLocation
                                                          );
                                                        }
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  )
                              ],
                            );
                          },
                        );
                      },
                    )
                  ),
                ),
              ]
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RaisedButton(
                          disabledColor: Colors.white,
                          disabledTextColor: Colors.blue[900],
                          color: Colors.blue[900],
                          textColor: Colors.white,
                          child: Text('На карте'),
                          onPressed: null,
                        ),
                        RaisedButton(
                          disabledColor: Colors.white,
                          disabledTextColor: Colors.blue[900],
                          color: Colors.blue[900],
                          textColor: Colors.white,
                          child: Text('Списком'),
                          onPressed: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => ShopList(shopList: shopList,controller: controller)));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _presentBottomSheet(BuildContext context) {
    var userSnapData;
    var shopSnapData;
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: <Widget>[
          StreamBuilder(
            stream: Observable.combineLatest2(_mapBloc.subjectShopObservable,
                _mapBloc.subjectUserPosObservable, (b1, b2) {
              userSnapData = b2;
              shopSnapData = b1;
            }),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (shopSnapData.shopAddress == null)
                            Text('Адрес магазина')
                          else
                            Text('${shopSnapData.shopAddress}'),
                          if (shopSnapData.shopDistance == null)
                            Text('')
                          else
                            Text('${num.parse(shopSnapData.shopDistance.toStringAsFixed(2))} КМ')
                        ],
                      ),
                    ),
                    Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 500,
                          minHeight: 50,
                        ),
                        child: FlatButton(
                          onPressed: () => {
                            launch( "https://yandex.ru/maps/?rtext=${userSnapData.latitude},${userSnapData.longitude}~${shopSnapData.shopPoint}&rtt=mt")
                          },
                          child: Text('Выбрать магазин'),
                          disabledTextColor: Colors.white,
                          color: Colors.orange[700],
                          disabledColor: Colors.orange[700],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapBloc.dispose();
  }
}
