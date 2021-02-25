import 'package:flutter/material.dart';
import 'package:forest_island/CameraApp.dart';
import 'package:forest_island/MapBloc.dart';
import 'package:forest_island/MapWidget.dart';
import 'package:forest_island/MyIntroductionScreen.dart';
import 'package:forest_island/Registration.dart';
import 'package:forest_island/ReviewScreen.dart';
import 'package:forest_island/ShareWidget.dart';
import 'package:forest_island/ShopList.dart';
import 'package:forest_island/StoriesScreen.dart';
import 'package:forest_island/widgets/SearchFieldWidget.dart';
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
          onPressed: onPressed),
    );
  }
}

class Shop { // *Привет класса магазина с полями, потом уберу
  String shopName;
  String shopAddress;
  YMaps.Point shopPosition;
  String shopStartTime;
  String shopEndTime;
  bool isFavorite;

  Shop(
    {
      this.shopName,
      this.shopAddress,
      this.shopStartTime,
      this.shopEndTime,
      this.shopPosition,
      this.isFavorite
    }
  );
}

class MapWidgetRav extends StatelessWidget {
  MapBloc _mapBloc = new MapBloc(
    shop: ShopInfo(),
    userPosition: Position(latitude: 55.753215, longitude: 37.622504),

  );
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
                  child: FutureBuilder( // * FutureBuilder для получения иконки магазинов
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
                    isFavorite: false
                  );

                  Shop testShop2 = new Shop(
                    shopAddress: 'ул Курчатова 22',
                    shopPosition:YMaps.Point(latitude: 55.150288, longitude: 61.390220), // * Тоже потом уберу
                    shopStartTime: '10:00',
                    shopEndTime: '19:00',
                    isFavorite: true
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
                        _mapBloc.subjectUserPosObservable, (b1, b2) { // ! StreamBuilder для получения местонахождения пользователя и инфы по магазу
                      userSnapData = b2;
                      shopSnapData = b1;
                    }),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      List<YMaps.Placemark> placemarkArray = [
                        YMaps.Placemark(
                          point: const YMaps.Point(latitude: 55.159393, longitude: 61.380302),
                          onTap: (YMaps.Point point) {
                            _mapBloc.updateLocation(); // * функция получения местоположения пользователя
                            _mapBloc.distanceCount(userSnapData.latitude,userSnapData.longitude, point.latitude,point.longitude); // * высчитывание расстояние от меня до магазина
                            _mapBloc.parseDaDa(point.latitude, point.longitude); // * парс дадаты для получения адреса магазина, потом уберу

                            _presentBottomSheet(context); // всплывает BottomSheet

                            _mapBloc.showToast(point.latitude, point.longitude); // ? вроде как бесполезная функция, потом уберу
                          },
                          style: YMaps.PlacemarkStyle( // * Дизайн иконки магазина на карте
                            opacity: 0.95,
                            zIndex: 1,
                            scale: 2,
                            rawImageData: tmpSnapData.buffer.asUint8List()
                          ),
                        ),
                        YMaps.Placemark(
                          point: const YMaps.Point(latitude: 55.150288, longitude: 61.390220),
                          onTap: (YMaps.Point point) {
                            _mapBloc.updateLocation();
                            _mapBloc.distanceCount(
                              userSnapData.latitude,
                              userSnapData.longitude,
                              point.latitude,
                              point.longitude);
                            _mapBloc.parseDaDa(point.latitude, point.longitude);

                            _presentBottomSheet(context);

                            _mapBloc.showToast(point.latitude, point.longitude);
                          },
                          style: YMaps.PlacemarkStyle(
                            opacity: 0.95,
                            zIndex: 2,
                            scale: 2,
                            rawImageData: tmpSnapData.buffer.asUint8List()
                          ),
                        )
                      ];

                      return new Stack(
                        children: <Widget>[
                          YMaps.YandexMap(
                            onMapCreated: (YMaps.YandexMapController yandexMapController) async { // * Настройки яндекс карты
                              controller = yandexMapController;
                              controller.toggleNightMode(enabled: true);
                              controller.move(
                                zoom: 12,
                                animation: YMaps.MapAnimation(),
                                point: const YMaps.Point(latitude: 55.164639,longitude: 61.401215)
                              );
                            },
                            onMapRendered: () {
                              _mapBloc.checkPermission(); // * Проверка, включен ли GPS у пользователя
                              geolocationDialog(context); // * модальное окно с текстом тип "включи GPS"
                              _mapBloc.updateLocation();
                              placemarkArray.forEach((element) {
                                controller.addPlacemark(element); // * Добавление точек на карту
                              });
                            },
                          ),
                          StreamBuilder(
                              stream: _mapBloc.subjectUserPosObservable,
                              builder: (context, snapshot) {
                                var tmpSnapShot = snapshot.data;
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          // height: 100,
                                          width: 40,
                                          child: Column(
                                            children: <Widget>[
                                              FutureBuilder(
                                                future: _mapBloc.getUserMarker(), // * FutureBuilder для получения картинки для иконки нахождения пользователя
                                                builder: (context, snapshot) {
                                                  var userPlacemark;
                                                  if (snapshot.connectionState != ConnectionState.done)
                                                    return Container();

                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff')))
                                                    ),
                                                    child: IconButton(
                                                      icon: Icon(Icons.navigation_outlined, color: Colors.white),
                                                      onPressed: () {
                                                        _mapBloc.updateLocation();

                                                        YMaps.Point userLocation = YMaps.Point(latitude: tmpSnapShot.latitude,longitude:tmpSnapShot.longitude);
                                                        userPlacemark = YMaps.Placemark(
                                                          point: userLocation,
                                                          style: YMaps.PlacemarkStyle(
                                                            opacity: 0.95,
                                                            zIndex: 1,
                                                            scale: 2,
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
                                                    ),
                                                  );
                                                }
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff')))
                                                  ),
                                                  child: IconButton(
                                                    icon: Icon(Icons.format_list_bulleted, color: Colors.white), // * функция которая показывает список магазинов
                                                    onPressed: () {
                                                      _presentShopList(context, shopList);
                                                    }
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
                                        width: MediaQuery.of(context).size.width,
                                        // height: MediaQuery.of(context).size.height * 1 / 7,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: AutoSizeText('Ближайший к Вам магазин', style: new TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600))
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5),
                                              child: Container(
                                                child: FlatButton(
                                                  onPressed: () {
                                                    _presentShopList(context, shopList);
                                                  },
                                                  child: Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      AutoSizeText('Лесопарковая 8', style: new TextStyle(fontSize: 16, color: Colors.white),  maxLines: 1),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                                        child: Icon(Icons.edit,color: Colors.white, size: 17),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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
    )
  );
}

  void geolocationDialog(BuildContext context) async { // * модальное окно с текстом тип "включи GPS"
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

  void _presentBottomSheet(BuildContext context) { // * модальное окно с инфой магазина
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
            stream: Observable.combineLatest2(_mapBloc.subjectShopObservable, // инфа с названием магазина и его координатами
              _mapBloc.subjectUserPosObservable, (b1, b2) {
              userSnapData = b2;
              shopSnapData = b1;
            }),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height * 1 / 7,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(18.0),
                      topRight: const Radius.circular(18.0)
                    ),
                    color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
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
                              CircularProgressIndicator()
                            else
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: AutoSizeText('${shopSnapData.shopAddress}',style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white), maxLines: 1),
                              ),
                            if (shopSnapData.shopDistance == null)
                              Text('')
                            else
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                    child: FlatButton.icon(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:BorderRadius.circular(9.0),
                                        side: BorderSide(color: Colors.white)
                                      ),
                                      onPressed: () { // при нажатии открывает яндекс карты с маршрутом
                                        launch("https://yandex.ru/maps/?rtext=${userSnapData.latitude},${userSnapData.longitude}~${shopSnapData.shopPoint}&rtt=mt");
                                      },
                                      icon: Icon(Icons.room_outlined , color: Colors.white),
                                      label: AutoSizeText('${num.parse(shopSnapData.shopDistance.toStringAsFixed(2))} км', style: new TextStyle(fontSize: 14, color: Colors.white), maxLines: 1,)
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                    child: FlatButton(
                                      child: AutoSizeText('Контакты', style: new TextStyle(fontSize: 14, color: Colors.white), maxLines: 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(9.0),
                                        side: BorderSide(color: Colors.white)),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                    child: FlatButton(
                                      child: Text('09:00 - 20:00', style: new TextStyle(fontSize: 14, color: Colors.white), maxLines: 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                          BorderRadius.circular(9.0),
                                        side:
                                          BorderSide(color: Colors.white)),
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
                                
                              },
                              child: AutoSizeText('Выбрать магазин', style: new TextStyle(fontSize: 18, color: Colors.white), maxLines: 1),
                              disabledTextColor: Colors.white,
                              color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
                              disabledColor: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
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

  void _presentShopList(BuildContext context, shopList) { // * Модальное окно с списком магазинов
    showModalBottomSheet(
        backgroundColor: Color(int.parse('0xFFF5F5F6')),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        context: context,
        builder: (context) => Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
               //crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Container(
                   //alignment: Alignment.center,
                   width: MediaQuery.of(context).size.width / 8,
                   decoration: BoxDecoration(
                     color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
                     border: Border.all(color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff')))),
                     borderRadius: BorderRadius.all(
                       Radius.circular(5.0)
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(15),
                   child: Container(
                     alignment: Alignment.centerLeft,
                     child: AutoSizeText('Выберите магазин', style: new TextStyle(fontSize: 20,fontWeight: FontWeight.w600),  maxLines: 1),
                   ),
                 ),
                 Container(
                   child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 1 / 16),
                    child: Container(
                      child: SearchFieldWidget(Colors.white),
                    ),
                  ),
                 ),
                 Container(
                   color: Colors.white,
                   height: MediaQuery.of(context).size.height * 3 / 4,
                   child: Padding(
                     padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                     child: ListView.builder(
                       itemCount: shopList.length,
                       itemBuilder: (context, i) {
                         return Container(
                           decoration: BoxDecoration(
                             border: Border(
                               top: BorderSide(
                                 color: Colors.grey[300],
                                 width: 0.8,
                               ),
                             ),
                           ),
                           child: GestureDetector(
                             onTap: () {
                               Navigator.pop(context);
                               controller.move(
                                 point: YMaps.Point(latitude: shopList[i].shopPosition.latitude,longitude: shopList[i].shopPosition.longitude)
                               );
                             },
                             child: StreamBuilder(
                               stream: _mapBloc.subjectIsFavShop,
                               initialData: false,
                               builder: (BuildContext context, AsyncSnapshot snapshot)
                               {
                                 return ListTile(
                                   leading: Transform.translate(
                                     offset: Offset(-16, 0),
                                     child: IconButton(
                                       icon: Icon(Icons.star, color: snapshot.data? Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))) : Colors.grey), 
                                       iconSize: 30,
                                       onPressed: () {
                                         _mapBloc.favShopToast(snapshot.data);
                                       }
                                     )
                                   ),
                                   title: Transform.translate(
                                     offset: Offset(-22, 0),
                                     child: AutoSizeText(shopList[i].shopAddress, style: new TextStyle(fontSize: 14),maxLines: 1)
                                   ),
                                   subtitle: Transform.translate(
                                     offset: Offset(-22, 0),
                                     child: AutoSizeText('График работы с ${shopList[i].shopStartTime} до ${shopList[i].shopEndTime}',style: new TextStyle(fontSize: 10),maxLines: 1)
                                   ),
                                 );
                               }
                             ),
                           ),
                         );
                       },
                     ),
                   ),
                 ),
               ],
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