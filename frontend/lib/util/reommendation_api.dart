import 'dart:convert';
import 'package:frontend/util/product_api.dart';
import 'package:http/http.dart' as http;

import '../models/product_simple.dart';

class RecommendationApi {
  static const String apiUrl = "http://j9a505.p.ssafy.io:8881/api";

  static Future<List<dynamic>> getRanking() async {
    final response = await http.get(Uri.parse('${ProductApi.apiUrl}/product/keyword-ranking'));
    // final response = null;
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final data1 = json.decode(body);
      final List<dynamic> data = data1['ranking']
        .map((item) => item as Map<String, dynamic>).toList();
      // final List<Map<String, String>> data = [];
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<ProductSimple>> getRecommendationListUser(String token) async {
    const String url = "$apiUrl/recommend/similarity";
    print('getting data from $url');
    final response = await http.get(Uri.parse(url), headers: ProductApi.getHeaderWithToken(token));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final List<ProductSimple> data = (json.decode(body) as List<dynamic>)
          .map((item) => ProductSimple.fromJson(item))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<ProductSimple>> getRecommendationListCombination(List<int> productIdList) async {
    final String productIdQuery = productIdList.map((productId) => 'productIdList=$productId').join('&');

    final String url = "$apiUrl/recommend/combination?$productIdQuery";
    print('getting data from $url');
    final response = await http.get(Uri.parse(url), headers: ProductApi.getHeaderWithToken(''));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final List<ProductSimple> data = (json.decode(body) as List<dynamic>)
          .map((item) => ProductSimple.fromJson(item))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<ProductSimple>> getRecommendationListNutrient(List<int> productIdList) async {
    final String productIdQuery = productIdList.map((productId) => 'productIdList=$productId').join('&');

    final String url = "$apiUrl/recommend/nutrient?$productIdQuery";
    print('getting data from $url');
    final response = await http.get(Uri.parse(url), headers: ProductApi.getHeaderWithToken(''));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final List<ProductSimple> data = (json.decode(body) as List<dynamic>)
          .map((item) => ProductSimple.fromJson(item))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}