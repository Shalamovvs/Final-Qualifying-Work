import 'package:forest_island/models/product/Product.dart';

class Section{
  final int id;

  final String sectionTitle;

  final List<Product> products;

  Section({
    this.products,
    this.id,
    this.sectionTitle
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    sectionTitle: json["sectionTitle"],
    products: (json["products"] as List<dynamic>).map((item) => Product.fromJson(item)).toList(),
  );

}

