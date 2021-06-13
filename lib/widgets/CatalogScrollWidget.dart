import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:forest_island/TestScreen.dart';
import 'package:forest_island/models/sections/Section.dart';
import 'package:forest_island/screens/ProductDetail.dart';

class CatalogScrollWidget extends StatelessWidget {
  List<Section> sectionList;

  CatalogScrollWidget(sectionList) {
    this.sectionList = sectionList;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: new ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: sectionList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: new Container(
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: AutoSizeText('${sectionList[index].sectionTitle}',style: new TextStyle(color: Colors.black,fontWeight: FontWeight.w600, fontSize: 18),maxLines: 1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          child: AutoSizeText('Смотреть все',style: new TextStyle(fontSize: 12),maxLines: 1,)
                        ),
                      )
                    ]
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 240),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: new ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(left: 20),
                        itemCount: sectionList[index].products.length,
                        itemBuilder: (context, idx) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product: sectionList[index].products[idx])));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8,bottom: 8,right: 16),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey[300],
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment:  CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.center,
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints( minHeight: 100, maxHeight: 100, maxWidth: 100),
                                              child: Image.network(
                                                sectionList[index].products[idx].image,
                                                width: MediaQuery.of(context).size.width / 2,
                                              )
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10, bottom: 15),
                                            child: Container(
                                              child: AutoSizeText('${sectionList[index].products[idx].name}',style: new TextStyle(color: Colors.black,fontSize: 12,fontWeight:FontWeight.w600),maxLines: 2),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                 sectionList[index].products[idx].oldPrice != null ?
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          child: AutoSizeText('${sectionList[index].products[idx].oldPrice}',maxLines: 1,style: new TextStyle(fontSize: 12,color: Colors.grey ,decoration: TextDecoration.lineThrough, decorationColor: Colors.green)),
                                                        ),
                                                        Container(
                                                          child: AutoSizeText('${sectionList[index].products[idx].price} ₽',style: new TextStyle(color: Colors.black,fontSize: 14,fontWeight:FontWeight.bold))
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                :
                                                  Container(
                                                    child: AutoSizeText('${sectionList[index].products[idx].price} ₽',style: new TextStyle(color: Colors.black,fontSize: 14,fontWeight:FontWeight.bold))
                                                  ),
                                                Padding(
                                                  padding:const EdgeInsets.only(right: 10),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child:SizedBox.fromSize(
                                                      child: ClipOval(
                                                        child: Material(
                                                          color: Colors.green[400],
                                                          child: InkWell(
                                                            splashColor: Colors.green,
                                                            onTap:() {},
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Icon(Icons.shopping_bag_outlined,color: Colors.white)
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ]
                                      ),
                                    ),
                                  ),
                                  sectionList[index].products[idx].promotionText != null ? 
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                        color: Colors.green[200],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AutoSizeText('${sectionList[index].products[idx].promotionText}', maxLines: 1, style: new TextStyle(fontSize: 9, color: Colors.white)),
                                      ),
                                    )
                                    :
                                    Container()
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
