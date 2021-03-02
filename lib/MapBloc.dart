import 'package:flutter/widgets.dart';
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

class MapBloc {
  ShopInfo shop = ShopInfo();
  Geolocator _geolocator;
  Position userPosition;
  bool isFavShop = false;
  Uint8List shopPlacemark;
  Uint8List userPlacemark;

  BehaviorSubject<ShopInfo> _subjectShop;
  BehaviorSubject<Position> _subjectUserPosition;
  BehaviorSubject<bool> _subjectIsFavShop;
  BehaviorSubject<Uint8List> _subjectUserPlacemark;
  BehaviorSubject<Uint8List> _subjectShopPlacemark;

  MapBloc({this.shop, this.userPosition}) {
    _subjectShop = new BehaviorSubject<ShopInfo>.seeded(this.shop);
    _subjectUserPosition = new BehaviorSubject<Position>.seeded(this.userPosition);
    _subjectIsFavShop = new BehaviorSubject<bool>.seeded(this.isFavShop);
    _subjectUserPlacemark = new BehaviorSubject<Uint8List>.seeded(this.userPlacemark);
    _subjectShopPlacemark = new BehaviorSubject<Uint8List>.seeded(this.shopPlacemark);
  }
  Observable<Position> get subjectUserPosObservable => _subjectUserPosition.stream;
  Observable<ShopInfo> get subjectShopObservable => _subjectShop.stream;
  Observable<bool> get subjectIsFavShop => _subjectIsFavShop.stream;
  Observable<Uint8List> get subjectUserPlacemark => _subjectUserPlacemark.stream;
  Observable<Uint8List> get subjectShopPlacemark => _subjectShopPlacemark.stream;

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

  Future<ByteData> getMarker() async {
    return await rootBundle.load('assets/images/ravis-marker.png');
  }

  Future<ByteData> getUserMarkerFuture() async {
    return await rootBundle.load('assets/images/user-location.png');
  }

  getUserMarker() async {
    ByteData data = await rootBundle.load('assets/images/user-location.png');
    Uint8List marker = data.buffer.asUint8List();
    _subjectUserPlacemark.sink.add(marker);
  }

  getShopMarker() async {
    ByteData data = await rootBundle.load('assets/images/ravis-marker.png');
    Uint8List shopMarker = data.buffer.asUint8List();
    _subjectShopPlacemark.sink.add(shopMarker);
  }

  void dispose() {
    _subjectShop.close();
    _subjectUserPosition.close();
    _subjectIsFavShop.close();
    _subjectUserPlacemark.close();
    _subjectShopPlacemark.close();
  }
}
