import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:forest_island/models/product/Product.dart';
import 'package:forest_island/models/sections/Section.dart';
import 'package:flutter/material.dart';
import 'package:forest_island/widgets/CatalogScrollWidget.dart';
import 'package:forest_island/widgets/SearchFieldWidget.dart';

class HomeScreen extends StatelessWidget {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  child: SearchFieldWidget(
                    Color(int.parse('#F5F5F6'.replaceAll('#', '0xff')))),
                ),
              ),
              FutureBuilder(
                future: loadSection(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done)
                  {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: CatalogScrollWidget(snapshot.data)
                      ),
                    );
                  }
                  else
                  {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<Section>> loadSection() async {
  final jsonString = await rootBundle.loadString('assets/json/products.json');

  var map = jsonDecode(jsonString)["sections"] as List<dynamic>;

  List<Section> sectionList = map.map((item) => Section.fromJson(item)).toList();

  return sectionList;
}
