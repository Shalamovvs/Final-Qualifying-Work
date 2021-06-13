import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:forest_island/models/product/Product.dart';
import 'package:forest_island/screens/CartScreen.dart';
import 'package:overlay_support/overlay_support.dart';

class ProductDetail extends StatelessWidget {
  Product product;

  ProductDetail({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: FloatingActionButton.extended(
          onPressed: () {
            showSimpleNotification(
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(Icons.shopping_cart_outlined,size: 30 ,color: Colors.white),
                    ),
                    AutoSizeText("Товар добавлен в корзину!", maxLines: 1, style: new TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                )
              ),
              background:  Colors.green[200]
            );
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.green[400],
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          label: AutoSizeText('Добавить в корзину', maxLines: 1, style: TextStyle(fontSize: 16)),
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
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
            }, 
            child: AutoSizeText('Корзина', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 16)),
          )
        ],
        title: AutoSizeText('Каталог', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 150),
                    child: Image.network('${product.image}', width: MediaQuery.of(context).size.width / 2)
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: RatingBar.builder(
                          initialRating: (product.rating),
                          minRating: 1,
                          maxRating: 5,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 20,
                          unratedColor: Color(int.parse('#E2E2E2'.replaceAll('#', '0xff'))),
                          itemPadding: EdgeInsets.symmetric(horizontal: 1),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.green[400],
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showSimpleNotification(
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Icon(Icons.favorite, color: Colors.red[600]),
                                  ),
                                  AutoSizeText("Товар добавлен в избранное!", maxLines: 1, style: new TextStyle(fontSize: 12, color: Colors.black)),
                                ],
                              )
                            ),
                            background:  Colors.green[200]
                          );
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green[400]),
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Icon(
                            Icons.favorite, 
                            color: Colors.green[400],
                            size: 18
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: AutoSizeText('${product.name}', maxLines: 2,textAlign: TextAlign.center ,style: new TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
                ),
                Container(
                  child: AutoSizeText('${product.price} Р', maxLines: 1, style: new TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AutoSizeText('${product.info}', style: TextStyle(fontSize: 16)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
