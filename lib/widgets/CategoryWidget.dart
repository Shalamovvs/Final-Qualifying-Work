import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CategoryWidget extends StatelessWidget {
  var categoryList;

  CategoryWidget(list) {
    this.categoryList = list;
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: new ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: categoryList.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: () {
              
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(int.parse('${categoryList[index].categoryColor}'.replaceAll('#', '0xff'))),
                ),
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: AutoSizeText('${categoryList[index].categoryTitle}', maxLines: 1, style: new TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: Image(image: categoryList[index].categoryImage.image),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}