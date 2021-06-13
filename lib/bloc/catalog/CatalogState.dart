import 'package:equatable/equatable.dart';
import 'package:forest_island/models/sections/Section.dart';

abstract class CatalogState extends Equatable {
  CatalogState();

  @override
  List<Object> get props => [];
}

class CatalogInitial extends CatalogState {}

class CatalogSuccess extends CatalogState {
  List<Section> sectionList;

  CatalogSuccess({this.sectionList});

  @override
  List<Object> get props => [sectionList];
}
