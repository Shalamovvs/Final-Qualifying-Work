import 'package:get/get_navigation/get_navigation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as YMaps;

class ShopInfo {
  var shopDistance;
  var shopPoint;
  String shopAddress;

  ShopInfo({this.shopAddress, this.shopDistance, this.shopPoint});
}

class Response {
  final String cityName;

  Response({this.cityName});

  factory Response.fromMap(Map<String, dynamic> map) {
    return Response(
      cityName: map["suggestions"][0]["value"] ?? "",
    );
  }
}

// !! ГЕОКОДИНГ
// class AddressResponce {
//   final String addressName;
//   final String addressCity;
//   final String lat;
//   final String lon;
//   final String testPos;

//  AddressResponce(
//       {this.addressName, this.addressCity, this.lat, this.lon, this.testPos});

//   factory AddressResponce.fromList(Map<String, dynamic> map) {
//     return AddressResponce(
//       testPos: map['response']['GeoObjectCollection']['featureMember'][0]
//               ['GeoObject']['Point']["pos"] ??
//           "",
//       // lon: map[0]["geo_lon"] ?? "",
//     );
//   }
// }

class MapBloc {
  ShopInfo shop = ShopInfo();
  Geolocator _geolocator;
  Position userPosition;
  bool isFavShop = false;

  BehaviorSubject<ShopInfo> _subjectShop;
  BehaviorSubject<Position> _subjectUserPosition;
  BehaviorSubject<bool> _subjectIsFavShop;

  MapBloc({this.shop, this.userPosition}) {
    _subjectShop = new BehaviorSubject<ShopInfo>.seeded(this.shop);
    _subjectUserPosition = new BehaviorSubject<Position>.seeded(this.userPosition);
    _subjectIsFavShop = new BehaviorSubject<bool>.seeded(this.isFavShop);
  }
  Observable<Position> get subjectUserPosObservable => _subjectUserPosition.stream;
  Observable<ShopInfo> get subjectShopObservable => _subjectShop.stream;
  Observable<bool> get subjectIsFavShop => _subjectIsFavShop.stream;

  void showToast(_shopPointLat, _shopPointLong) {
    shop.shopPoint = '$_shopPointLat,$_shopPointLong';
    // print('Нужная точка ${shop.shopPoint}');
    // print('Местоположение пользователя ${userPosition.latitude},${userPosition.longitude}');
    _subjectShop.sink.add(shop);
  }

  void favShopToast(_isFavShop) {
    if (_isFavShop) 
    {
      isFavShop = false;
      _subjectIsFavShop.sink.add(isFavShop);
    }
    else
    {
      isFavShop = true;
      _subjectIsFavShop.sink.add(isFavShop);
    }
  }

  void checkPermission() {
    _geolocator = Geolocator();
    _geolocator.checkGeolocationPermissionStatus().then((status) {
      print('status: $status');
    });
    _geolocator
        .checkGeolocationPermissionStatus(
            locationPermission: GeolocationPermission.locationAlways)
        .then((status) {
      print('always status: $status');
    });
    _geolocator
        .checkGeolocationPermissionStatus(
            locationPermission: GeolocationPermission.locationWhenInUse)
        .then((status) {
      if (status == GeolocationStatus.granted) updateLocation();

      print('whenInUse status: $status');
    });
  }

  void updateLocation() async {
    try {
      Position newPosition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      userPosition = newPosition;
      // print(userPosition);
      _subjectUserPosition.sink.add(userPosition);
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void distanceCount(userLatitude, userLongitude, markLatitude, markLongitude) {
    deg2rad(deg) {
      return deg * (pi / 180);
    }

    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(markLatitude - userLatitude); // deg2rad below
    var dLon = deg2rad(markLongitude - userLongitude);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(userLatitude)) *
            cos(deg2rad(markLatitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c; // Distance in
    shop.shopDistance = d;
    _subjectShop.sink.add(shop);
  }

  void parseDaDa(double lat, double lon) async {
    final response = await http.get(
      'https://suggestions.dadata.ru/suggestions/api/4_1/rs/geolocate/address?lat=$lat&lon=$lon',
      // Send authorization headers to the backend.
      headers: {
        "radius_meters": '5',
        HttpHeaders.authorizationHeader:
            "Token 676a09578878d73dd94722234d4fd46000dc84a2",
        'Accept': 'application/json',
      },
    );
    // print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");
    final parsed = jsonDecode(response.body) as Map<String, dynamic>;
    Response resp = Response.fromMap(parsed);
    shop.shopAddress = resp.cityName;
    _subjectShop.sink.add(shop);
  }

  // !! ГЕОКОДЕР
  // void searchShop(address) async {
  //   var response = await http.get('https://geocode-maps.yandex.ru/1.x/?format=json&apikey=ddb34986-bcf5-4a2f-9145-59e2e0fed67d&geocode=Челябинск+$address');

  //   var url = 'https://cleaner.dadata.ru/api/v1/clean/address';
  //   var data = '[ "Челябинск $address" ]';
  //   Dio dio = new Dio();
  //   dio.options.headers['Content-Type'] = 'application/json';
  //   dio.options.headers['X-Secret'] =
  //       '1309c2cc44371ed9767ac85ceb0aa6e88be9c136';
  //   dio.options.headers["Authorization"] =
  //       "Token 5c6f39c9d25b9aebba8497133e221958ded608b7";
  //   final response = await dio.post(url, data: data);

  //   AddressResponce resp = AddressResponce.fromList(response.data);
  //   _subjectSearchPosition.sink.add(searchPosition);

  //   print("Response status: ${response.statusCode}");
  //   print("Response body: ${response.body}");

  //   final parsed = jsonDecode(response.body) as Map<String, dynamic>;
  //   AddressResponce resp = AddressResponce.fromList(parsed);
  //   searchPosition = YMaps.Point(latitude: double.parse(resp.lat), longitude: double.parse(resp.lon));
  // }

  Future<ByteData> getMarker() async {
    return await rootBundle.load('assets/images/ravis-marker.png');
  }

  Future<ByteData> getUserMarker() async {
    return await rootBundle.load('assets/images/user-location.png');
  }

  void dispose() {
    _subjectShop.close();
    _subjectUserPosition.close();
    _subjectIsFavShop.close();
  }
}
