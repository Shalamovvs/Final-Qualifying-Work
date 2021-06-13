import 'package:equatable/equatable.dart';
import 'package:forest_island/models/product/Product.dart';

abstract class CartState extends Equatable {
  CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartSuccess extends CartState {
  final int cartPrice;
  final List<Product> cartList;

  CartSuccess({this.cartPrice, this.cartList});

  CartSuccess copyWith({
  final int cartPrice,
  final List<Product> cartList,


  }) {
    return CartSuccess(
      cartPrice: cartPrice ?? this.cartPrice,
      cartList: cartList ?? this.cartList,
    );
  }

  @override
  List<Object> get props => [cartPrice, cartList];
}
