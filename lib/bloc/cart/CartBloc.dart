

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forest_island/bloc/cart/CartEvent.dart';
import 'package:forest_island/bloc/cart/CartState.dart';
import 'package:forest_island/models/product/Product.dart';

class CartBloc extends Bloc<CartEvent, CartState>{
  CartBloc() : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    final currentState = state;
    if (event is CartCreate){
      yield CartSuccess(cartList: event.cartList, cartPrice: event.cartPrice);
		}

    if (event is CartSumPrice){
      event.cartPrice += event.productPrice;
      int cartSum = event.cartPrice;
      if (currentState is CartSuccess)
      {
        yield currentState.copyWith(cartPrice: cartSum);
      }
      else
			  yield CartSuccess(cartPrice: cartSum);
		}

    if (event is CartRemoveItem){
      int index = event.cartList.indexOf(event.product);
      event.cartList.removeAt(index);
      List<Product> productList = event.cartList;

      if (currentState is CartSuccess)
      {
        yield currentState.copyWith(cartList: productList);
      }
      else
			  yield CartSuccess(cartList: productList);
		}
  }
}