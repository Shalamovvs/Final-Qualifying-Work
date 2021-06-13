import 'package:equatable/equatable.dart';

abstract class CatalogEvent extends Equatable{
	@override
	List<Object> get props => [];
}


// ignore: must_be_immutable
class CatalogCreate extends CatalogEvent {}