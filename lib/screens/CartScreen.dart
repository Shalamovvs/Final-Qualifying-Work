import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forest_island/bloc/cart/CartBloc.dart';
import 'package:forest_island/bloc/cart/CartEvent.dart';
import 'package:forest_island/bloc/cart/CartState.dart';
import 'package:forest_island/models/product/Product.dart';
import 'package:forest_island/screens/MadeOrder.dart';
import 'package:page_transition/page_transition.dart';

class CartScreen extends StatelessWidget {
  CartBloc cartBloc = new CartBloc();
  int cartCount = 0;

  @override
  Widget build(BuildContext context) {
    cartBloc.add(CartCreate());
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, PageTransition(type: PageTransitionType.fade,child: MadeOrder()));
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.green[400],
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          label: AutoSizeText('Оформить заказ', maxLines: 1, style: TextStyle(fontSize: 16)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        leadingWidth: 80,
        toolbarHeight: 50,
        centerTitle: true,
        leading: FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          child: AutoSizeText('Назад', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 16)),
        ),
        title: AutoSizeText('Корзина', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        cubit: cartBloc,
        builder: (context, state) {
          if(state is CartSuccess)
          {
            return Column(
              children: [
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.cartList.length,
                    itemBuilder: (context, index) {
                      if(cartCount <= state.cartList.length)
                      {
                        cartBloc.add(CartSumPrice(productPrice: state.cartList[index].price, cartPrice: state.cartPrice));
                        cartCount++;
                      }
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: (Colors.grey[200])
                            )
                          )
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                              alignment: Alignment.center,
                              child: ConstrainedBox(
                                constraints: BoxConstraints( maxWidth: 140, maxHeight: 100),
                                child: Container(
                                  width: 70,
                                  height: 55,
                                  child: Image.network(state.cartList[index].image)
                                )
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width / 2,
                                          child: AutoSizeText('${state.cartList[index].name}', maxLines: 1, style: new TextStyle(fontSize: 16))
                                        ),
                                        GestureDetector(
                                          child: Icon(Icons.close),
                                          onTap: () {
                                            cartBloc.add(CartRemoveItem(cartList: state.cartList, product: state.cartList[index]));
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        AutoSizeText('${state.cartList[index].price} ₽', maxLines: 1, style: new TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AutoSizeText('Итого', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green[400])),
                      AutoSizeText('${state.cartPrice} Р', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18))
                    ],
                  ),
                )
              ],
            );
          }
          else
          {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}