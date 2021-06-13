class Product {
  final int id;

  final String image;

  final String info;

  final String name;

  final int price;

  final String promotionText;

  final int oldPrice;

  final double rating;

  Product({
    this.id,
    this.image,
    this.info,
    this.name,
    this.price,
    this.oldPrice,
    this.promotionText,
    this.rating
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    image: json["image"],
    info: json["info"],
    name: json["name"],
    price: json["price"],
    oldPrice: json["oldPrice"],
    rating: json["rating"],
    promotionText: json["promotionText"]
  );
}

