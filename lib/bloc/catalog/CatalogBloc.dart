
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forest_island/bloc/catalog/CatalogEvent.dart';
import 'package:forest_island/bloc/catalog/CatalogState.dart';
import 'package:forest_island/models/sections/Section.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState>{
  CatalogBloc() : super(CatalogInitial());

  @override
  Stream<CatalogState> mapEventToState(CatalogEvent event) async* {

    if (event is CatalogCreate){

      List<Section> sectionList = await loadSection();
      yield CatalogSuccess(sectionList: sectionList);
		}
  }
}


Future loadSection() async {

  final jsonString  = await rootBundle.loadString('assets/json/products.json');

  var map = jsonDecode(jsonString)["sections"] as List<dynamic>;

  List<Section> sectionList = map.map((item) => Section.fromJson(item)).toList();

  return sectionList;
}