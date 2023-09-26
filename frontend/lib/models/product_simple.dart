
class ProductSimple {
  // productId : Long,
  // productName : String,
  // price : Int,
  // filename : String,
  // badge : String,
  // isFavorite: Boolean
  final int productId;
  final String productName;
  final int price;
  final String filename;
  final List<dynamic>? convenienceCode;
  final List<dynamic>? promotionCode;
  final bool? isFavorite;

  ProductSimple({
    required this.productId,
    required this.price,
    required this.filename,
    required this.productName,
    this.convenienceCode,
    this.promotionCode,
    this.isFavorite,
  });

  factory ProductSimple.fromJson(Map<String, dynamic> json) {

    if (json['productName'] == Null) {
      print('-==-------------got null');
      print(json);
    }
    return ProductSimple(
      productId: json['productId'],
      price: json['price'],
      filename: json['filename'],
      productName: json['productName'],
      convenienceCode: json['convenienceCode'],
      promotionCode: json['promotionCode'],
      isFavorite: json['isFavorite'],
    );
  }
}
