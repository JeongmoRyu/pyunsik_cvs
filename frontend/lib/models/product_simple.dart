import 'package:flutter/material.dart';

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
  final String badge;
  final bool? isFavorite;

  ProductSimple({
    required this.productId,
    required this.price,
    required this.filename,
    required this.productName,
    required this.badge,
    this.isFavorite,
  });

  factory ProductSimple.fromJson(Map<String, dynamic> json) {
    return ProductSimple(
      productId: json['productId'],
      price: json['price'],
      filename: json['filename'],
      productName: json['productName'],
      badge: json['badge'],
      isFavorite: json['isFavorite'],
    );
  }
}
