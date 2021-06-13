import 'package:equatable/equatable.dart';
import 'package:forest_island/models/product/Product.dart';

abstract class CartEvent extends Equatable{

	@override
	List<Object> get props => [];
}

class CartCreate extends CartEvent {
  final int cartPrice = 0;
  final List<Product> cartList = [testProduct1,testProduct2];
}

class CartSumPrice extends CartEvent {
  int cartPrice; 
  final int productPrice;

  CartSumPrice({this.cartPrice,this.productPrice});

  @override
  List<Object> get props => [cartPrice];
}

class CartRemoveItem extends CartEvent {
  final List<Product> cartList;
  final Product product;

  CartRemoveItem({this.cartList, this.product});

  @override
	List<Object> get props => [cartList];
}

Product testProduct1 = new Product(
  id: 1,
  image: 'https://avatars.mds.yandex.net/get-mpic/4080439/img_id3396893556724706605.jpeg/orig',
  name: 'Sony Playstation 5',
  price: 64990
);

Product testProduct2 = new Product(
  id: 2,
  image: 'https://items.s1.citilink.ru/1438626_v01_b.jpg',
  name: 'Playstation DualSense',
  price: 5999
);