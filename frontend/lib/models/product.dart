import 'package:flutter/material.dart';

@immutable
class Product {
  int id;
  String productName;
  String fileName;
  int price;

  Product(this.id, this.productName, this.fileName, this.price);

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