import 'package:flutter/material.dart';
import 'package:forest_island/CameraApp.dart';
import 'package:forest_island/MapBloc.dart';
import 'package:forest_island/MapWidget.dart';
import 'package:forest_island/MyIntroductionScreen.dart';
import 'package:forest_island/Registration.dart';
import 'package:forest_island/ShareWidget.dart';
import 'package:forest_island/ShopList.dart';
import 'package:forest_island/StoriesScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as YMaps;
import 'package:url_launcher/url_launcher.dart';
import 'package:rxdart/rxdart.dart';
import 'package:page_transition/page_transition.dart';
import 'package:auto_size_text/auto_size_text.dart';

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

class MapWidgetRav extends StatelessWidget {
  MapBloc _mapBloc = new MapBloc(
      isVisible: false,
      shop: ShopInfo(),
      userPosition: Position(latitude: 55.753215, longitude: 37.622504));
  YMaps.YandexMapController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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

                  Shop testShop = new Shop(
                    shopAddress: 'пр Ленина 73',
                    shopPosition:YMaps.Point(latitude: 55.159393, longitude: 61.380302),
                    shopStartTime: '09:00',
                    shopEndTime: '20:00',
                  );

                  Shop testShop2 = new Shop(
                    shopAddress: 'ул Курчатова 22',
                    shopPosition:YMaps.Point(latitude: 55.150288, longitude: 61.390220),
                    shopStartTime: '10:00',
                    shopEndTime: '19:00',
                  );

                  List<Shop> shopList = [
                    testShop,
                    testShop2,
                    testShop,
                    testShop2,
                    testShop,
                    testShop2,
                    testShop,
                    testShop2,
                    testShop,
                    testShop,
                    testShop
                  ];

                  return StreamBuilder(
                    stream: Observable.combineLatest2(
                        _mapBloc.subjectShopObservable,
                        _mapBloc.subjectUserPosObservable, (b1, b2) {
                      userSnapData = b2;
                      shopSnapData = b1;
                    }),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      List<YMaps.Placemark> placemarkArray = [
                        YMaps.Placemark(
                          point: const YMaps.Point(
                              latitude: 55.159393, longitude: 61.380302),
                          onTap: (YMaps.Point point) {
                            _mapBloc.parseDaDa(point.latitude, point.longitude);
                            _mapBloc.updateLocation();
                            _mapBloc.distanceCount(
                              userSnapData.latitude,
                              userSnapData.longitude,
                              point.latitude,
                              point.longitude);

                            while(shopSnapData.shopAddress = null)
                            {
                              
                            }

                            _presentBottomSheet(context);

                            _mapBloc.showToast(shopSnapData.shopAddress,point.latitude, point.longitude);
                          },
                          style: YMaps.PlacemarkStyle(
                            opacity: 0.95,
                            zIndex: 1,
                            scale: 0.2,
                            rawImageData: tmpSnapData.buffer.asUint8List()
                          ),
                        ),
                        YMaps.Placemark(
                          point: const YMaps.Point(latitude: 55.150288, longitude: 61.390220),
                          onTap: (YMaps.Point point) {
                            _mapBloc.parseDaDa(55.164639, 61.401215);
                            _mapBloc.updateLocation();
                            _mapBloc.distanceCount(
                              userSnapData.latitude,
                              userSnapData.longitude,
                              point.latitude,
                              point.longitude);

                            _presentBottomSheet(context);

                            _mapBloc.showToast(shopSnapData.shopAddress,point.latitude, point.longitude);
                          },
                          style: YMaps.PlacemarkStyle(
                              opacity: 0.95,
                              zIndex: 2,
                              scale: 0.2,
                              rawImageData: tmpSnapData.buffer.asUint8List()),
                        )
                      ];

                      return new Stack(
                        children: <Widget>[
                          YMaps.YandexMap(
                            onMapCreated: (YMaps.YandexMapController
                                yandexMapController) async {
                              controller = yandexMapController;
                              controller.toggleNightMode(enabled: true);
                              controller.move(
                                zoom: 12,
                                animation: YMaps.MapAnimation(),
                                point: const YMaps.Point(latitude: 55.164639,longitude: 61.401215)
                              );
                            },
                            onMapRendered: () {
                              _mapBloc.checkPermission();
                              geolocationDialog(context);
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
                                    height: 100,
                                    width: 40,
                                    child: Column(
                                      children: <Widget>[
                                        FutureBuilder(
                                          future: _mapBloc.getUserMarker(),
                                          builder: (context, snapshot) {
                                            var userPlacemark;
                                            if (snapshot.connectionState != ConnectionState.done)
                                              return Container();

                                            return IconButton(
                                              icon: Icon(Icons.navigation_outlined),
                                              onPressed: () {
                                                _mapBloc.updateLocation();
                                                YMaps.Point userLocation =
                                                  YMaps.Point(
                                                    latitude:tmpSnapShot.latitude,
                                                    longitude:tmpSnapShot.longitude
                                                  );
                                                userPlacemark =YMaps.Placemark(
                                                  point: userLocation,
                                                  style: YMaps.PlacemarkStyle(
                                                    opacity: 0.95,
                                                    zIndex: 1,
                                                    scale: 0.1,
                                                    rawImageData: snapshot.data.buffer.asUint8List()
                                                  ),
                                                );
                                                controller.addPlacemark(userPlacemark);
                                                controller.move(
                                                  zoom: 12,
                                                  animation: YMaps.MapAnimation(),
                                                  point: userLocation
                                                );
                                              }
                                            );
                                          }
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.format_list_bulleted_sharp),
                                          onPressed: () {
                                            _presentShopList(context, shopList);
                                          }
                                        )
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
              )),
            ),
          ]
        ),
    ));
  }

  void geolocationDialog(BuildContext context) async {
    final Geolocator _geolocator = Geolocator();
    bool enabled = await _geolocator.isLocationServiceEnabled();
    if (enabled) {
    } else {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      );

      AlertDialog alert = AlertDialog(
        content: Text("Чтобы продолжить, включите на устройстве геолокацию"),
        actions: [
          okButton,
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  void _presentBottomSheet(BuildContext context) {
    var userSnapData;
    var shopSnapData;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      context: context,
      builder: (context) => Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: <Widget>[
          StreamBuilder(
            stream: Observable.combineLatest2(_mapBloc.subjectShopObservable,
                _mapBloc.subjectUserPosObservable, (b1, b2) {
              userSnapData = b2;
              shopSnapData = b1;
            }),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height * 1 / 5,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(18.0),
                      topRight: const Radius.circular(18.0)),
                    color: Colors.orange[800],
                    boxShadow: [
                      BoxShadow(color: Colors.transparent, spreadRadius: 3),
                    ],
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (shopSnapData.shopAddress == null)
                              Text('Адрес магазина')
                            else
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: AutoSizeText('${shopSnapData.shopAddress}',
                                  style: new TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            if (shopSnapData.shopDistance == null)
                              Text('')
                            else
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric( horizontal: 5, vertical: 3),
                                    child: FlatButton.icon(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                          BorderRadius.circular(9.0),
                                        side:
                                          BorderSide(color: Colors.white)
                                      ),
                                      onPressed: () {
                                        launch("https://yandex.ru/maps/?rtext=${userSnapData.latitude},${userSnapData.longitude}~${shopSnapData.shopPoint}&rtt=mt");
                                      },
                                      icon: Icon(Icons.room_outlined),
                                      label: Text('${num.parse(shopSnapData.shopDistance.toStringAsFixed(2))} км', style: new TextStyle(fontSize: 12))
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric( horizontal: 5, vertical: 3),
                                    child: FlatButton(
                                      child: Text('Контакты', style: new TextStyle(fontSize: 12)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:BorderRadius.circular(9.0),
                                        side: BorderSide(color: Colors.white)
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric( horizontal: 5, vertical: 3),
                                    child: FlatButton(
                                      child: Text('09:00 - 20:00', style: new TextStyle(fontSize: 12)),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:BorderRadius.circular(9.0),
                                          side: BorderSide(color: Colors.white)),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: FlatButton(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: WorksScreen()
                                    )
                                  )
                                },
                                child: Text('Выбрать магазин', style: new TextStyle(fontSize: 18),),
                                disabledTextColor: Colors.white,
                                color: Colors.orange[700],
                                disabledColor: Colors.orange[700],
                              ),
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _presentShopList(BuildContext context, shopList) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        context: context,
        builder: (context) => Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                height: MediaQuery.of(context).size.height * 3 / 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: shopList.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[800],
                            borderRadius:BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ListTile(
                            title: AutoSizeText(shopList[i].shopAddress,style: new TextStyle(fontSize: 18), maxLines: 1),
                            subtitle: AutoSizeText('${shopList[i].shopStartTime} - ${shopList[i].shopEndTime}',style: new TextStyle(fontSize: 18), maxLines: 1),
                            trailing: FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                                controller.move(
                                  point: YMaps.Point(latitude: shopList[i].shopPosition.latitude,longitude: shopList[i].shopPosition.longitude)
                                );
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                  BorderRadius.circular(9.0),
                                side:
                                  BorderSide(color: Colors.white)
                                ),
                              disabledTextColor: Colors.orange[800],
                              disabledColor: Colors.white,
                              child: Text('Показать на карте')
                            )
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        )
      );
  }

  @override
  void dispose() {
    _mapBloc.dispose();
  }
}

class WorksScreen extends StatelessWidget {
  const WorksScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: RegistrationFirstPage()));
                },
                child: Text('Регистрация')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: StoriesScreen()));
                },
                child: Text('Сторис')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: MyIntroductionScreen()));
                },
                child: Text('Приветствие')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: ShareWidget()));
                },
                child: Text('Шаринг')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: MapWidget()));
                },
                child: Text('Витаминка Карта')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: CameraScreen()));
                },
                child: Text('Считывание штрихкодов')),
          )
        ],
      ),
    );
  }
}

// class ShopSearch extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     MapBloc _mapBloc = new MapBloc(
//         isVisible: false,
//         shop: ShopInfo(),
//         userPosition: Position(latitude: 55.753215, longitude: 37.622504));
//     dynamic searchField = '';
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           child: Column(
//             children: <Widget>[
//               StreamBuilder<Object>(
//                   stream: _mapBloc.subjectSearchPosObservable,
//                   builder: (context, snapshot) {
//                     return Container(
//                       child: TextField(
//                         onEditingComplete: () {
//                           print(snapshot.data);
//                           _mapBloc.searchShop(searchField);
//                         },
//                         onChanged: (text) {
//                           searchField = text;
//                         },
//                         decoration: InputDecoration(
//                           hintText: 'Поиск',
//                           prefixIcon: IconButton(
//                             onPressed: () {
//                               Navigator.pop( context,PageTransition(type: PageTransitionType.fade,child: MapWidgetRav()));
//                             },
//                             icon: Icon(Icons.arrow_back),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//               Container(
//                 child: SingleChildScrollView(
//                   child: Container(),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
