import 'package:flutter/material.dart';

@immutable
class Product {
  int id;
  String productName;
  String fileName;
  int price;
  int? kcal;

  Product(this.id, this.productName, this.fileName, this.price);

  Product.withKcal(this.id, this.productName, this.fileName, this.price, this.kcal);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Product && other.id == id;

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
