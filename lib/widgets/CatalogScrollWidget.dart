import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CatalogScrollWidget extends StatelessWidget {
  var sectionList;

  CatalogScrollWidget(sectionList) {
    this.sectionList = sectionList;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: new ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: sectionList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Container(
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: AutoSizeText('${sectionList[index].sectionTitle}',style: new TextStyle(color: Colors.black,fontWeight: FontWeight.w600, fontSize: 18),maxLines: 1),
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
                        // height: 220,
                        width: MediaQuery.of(context).size.width,
                        child: new ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: sectionList[index].itemName.length,
                          itemBuilder: (context, idx) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8,bottom: 8,right: 16),
                              child: new Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[300],
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
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
                                          constraints: BoxConstraints( minHeight: 100, maxHeight: 100),
                                          child: Image(
                                            image: sectionList[index].itemImage[idx].image,
                                            width: MediaQuery.of(context).size.width / 2,
                                          )
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          child: AutoSizeText('${sectionList[index].itemName[idx]}',style: new TextStyle(color: Colors.black,fontSize: 12,fontWeight:FontWeight.w600),maxLines: 2),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Container(
                                          child: AutoSizeText('1кг', style: new TextStyle(color: Colors.black,fontSize: 12), maxLines: 1),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: AutoSizeText('${sectionList[index].itemPrice[idx]} ₽',style: new TextStyle(color: Colors.black,fontSize: 14,fontWeight:FontWeight.bold))
                                            ),
                                            Padding(
                                              padding:const EdgeInsets.only(right: 10),
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                child:SizedBox.fromSize(
                                                  // button width and height
                                                  child: ClipOval(
                                                    child: Material(
                                                      color: Colors.orange[800], // button color
                                                      child: InkWell(
                                                        splashColor: Colors.green, // splash color
                                                        onTap:() {}, // button pressed
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            Icon(Icons.shopping_bag_outlined,color: Colors.white) //t
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
        ),
      )
    );
  }
}
