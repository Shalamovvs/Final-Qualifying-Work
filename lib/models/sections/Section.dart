import 'package:forest_island/models/product/Product.dart';

class Section{
  final String sectionTitle;

  final List<Product> products;

  Section({
    this.products,
    this.sectionTitle
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    sectionTitle: json["sectionTitle"],
    products: (json["products"] as List<dynamic>).map((item) => Product.fromJson(item)).toList(),
  );

}

