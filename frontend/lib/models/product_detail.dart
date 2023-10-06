import 'package:flutter/material.dart';

@immutable
class Comment {
  final String nickname;
  final String content;
  final String createdAt;

  Comment({
    required this.nickname,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      nickname: json['nickname'],
      content: json['content'],
      createdAt: json['createdAt'],
    );
  }
}

class ProductDetail {
  late int _productId;
  final String productName;
  final int price;
  final String filename;
  final int category;
  final int favoriteCount;
  final int weight;
  final int kcal;
  final double carb;
  final double protein;
  final double fat;
  final double sodium;
  final List<dynamic> convenienceCode;
  final List<dynamic> promotionCode;
  final List<Comment> comments;
  final bool? isFavorite;

  set productId(int value) {
    _productId = value;
  }

  int get productId => _productId;

  ProductDetail({
    required this.price,
    required this.filename,
    required this.productName,
    required this.promotionCode,
    required this.category,
    required this.favoriteCount,
    required this.weight,
    required this.kcal,
    required this.carb,
    required this.protein,
    required this.fat,
    required this.sodium,
    required this.convenienceCode,
    required this.comments,
    this.isFavorite,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    List<Comment> commentsList = (json['comments'] as List<dynamic>?)
        ?.map((commentJson) => Comment.fromJson(commentJson))
        .toList() ?? [];

    return ProductDetail(
      price: json['price'],
      filename: json['filename'],
      productName: json['productName'],
      promotionCode: json['promotionCode'],
      category: json['category'],
      favoriteCount: json['favoriteCount'],
      weight: json['weight'],
      kcal: json['kcal'],
      carb: json['carb'],
      protein: json['protein'],
      fat: json['fat'],
      sodium: json['sodium'],
      convenienceCode: json['convenienceCode'],
      isFavorite: json['isFavorite'],
      comments: commentsList,
    );
  }
}
