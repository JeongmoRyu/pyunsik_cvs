class Product {
  int? id;
  String productName;
  String fileName;
  int price;

  Product(this.id, this.productName, this.fileName, this.price);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'fileName': fileName,
      'price': price,
    };
  }

  //Product.fromJson(Map<String, dynamic> json);



}