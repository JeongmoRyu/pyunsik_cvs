import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'filter.dart';
//선택된 카테고리 표시,
//선택된 옵션 삭제 버튼
// 가격 원 기본 최소 ~ 최대 금액
// 행사여부
// 편의점 별
class ProductList extends ChangeNotifier {
  late Filter _filter;

  // final List<Product> _products = [];
  // final List<Product> _products = [
  //   new Product(1, 'test product short', '', 1800),
  //   new Product(2, 'test product middle middle', '', 39900),
  //   new Product(3, 'test product long long long long long long long', '', 1498000),
  //   new Product(4, 'test product short', '', 1800),
  //   new Product(5, 'test product short', '', 1800),
  //   new Product(6, 'test product short', '', 1800),
  //   new Product(7, 'test product short', '', 1800),
  //   new Product(8, 'test product short', '', 1800),
  //   new Product(8, 'test product short', '', 1800),
  //   new Product(8, 'test product short', '', 1800),
  //   new Product(8, 'test product short', '', 1800),
  //   new Product(8, 'test product short', '', 1800),
  //   new Product(8, 'test product short', '', 1800),
  // ];
  final List<Product> _products = [
    new Product(1, 'test product short', '', 1800),
    new Product(2, 'test product middle middle', '', 39900),
    new Product(3, 'test product long long long long long long long', '', 1498000),
    new Product(4, 'test product short', '', 1800),
    new Product(5, 'test product short', '', 1800),
    new Product(6, 'test product short', '', 1800),
    new Product(7, 'test product short', '', 1800),
    new Product(8, 'test product short', '', 1800),
    new Product(8, 'test product short', '', 1800),
    new Product(8, 'test product short', '', 1800),
    new Product(8, 'test product short', '', 1800),
    new Product(8, 'test product short', '', 1800),
    new Product(8, 'test product short', '', 1800),
  ];


  List<Product> get products => _products;
  int get numberOfProducts => _products.length;
  Filter get filter => _filter;

  set filter(Filter newFilter) {
    _filter = newFilter;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }

  Future<List<dynamic>> getList() async {
    //필터링 쿼리 적용한 rest api 호출
    final String apiUrl = "http://j9a505.p.ssafy.io:8881/api/product/";

    var queryParams = {
      'price' : ['${filter.filterRange['가격 (원)']?[0]}', '${filter.filterRange['가격 (원)']?[1]}'],
    };
    return fetchData(queryParams);
  }

  Uri getUri() {
    var queryParams = {
      'price' : ['${filter.filterRange['가격 (원)']?[0]}', '${filter.filterRange['가격 (원)']?[1]}'],
    };
    final uri =
    Uri.http('j9a505.p.ssafy.io:8881', '/api/product', queryParams);
    return uri;
  }

  Future<List<dynamic>> fetchData(var queryParams) async {
    final uri =
    Uri.http('j9a505.p.ssafy.io:8881', '/api/product', queryParams);
    print(uri);
    final headers = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final Future<List<dynamic>> data = json.decode(body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}