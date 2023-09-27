import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_detail.dart';
void main() {

  ProductApi.fetchProductList('', {'price': ['100', '1000'],}).then((result) {
    print(result);
  });
}
class ProductApi {
  static Map<String, String> getHeaderWithToken(String token) {
    return {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': token,
    };
  }

  static const String apiUrl = "http://j9a505.p.ssafy.io:8881/api/";

  static Future<List<dynamic>> fetchProductList(String token, Map<String, dynamic> queryParams) async {
    print('network got ${queryParams}');
    final uri = Uri.parse('${apiUrl}product').replace(queryParameters: queryParams);
    print('fetching data from $uri');
    final response = await http.get(uri, headers: getHeaderWithToken(token));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final List<dynamic> data = json.decode(body);
      return data;
    } else {
      throw Exception('Failed to load data. Status Code: ${response.statusCode}');
    }
  }

  static Future<ProductDetail> fetchProductDetail(String token, int productId) async {
    final uri = Uri.parse('${apiUrl}product/$productId');
    print('fetching data from $uri');
    final response = await http.get(uri, headers: ProductApi.getHeaderWithToken(token));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = json.decode(body);
      return ProductDetail.fromJson(data);
    } else {
      throw Exception('Failed to load data. Status Code: ${response.statusCode}');
    }
  }

  static Future<dynamic> addFavorite(int productId, String token) async {
    final response = await http.post(
      Uri.parse('$apiUrl/favorite/$productId'),
      headers: getHeaderWithToken(token),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return response;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to add favorite: ${jsonDecode(response.body)}');
    }
  }

  static Future<dynamic> getFavorites(int productId, String token) async {
    final response = await http.post(
      Uri.parse('$apiUrl/favorite/$productId'),
      headers: getHeaderWithToken(token),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return response;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to add favorite: ${jsonDecode(response.body)}');
    }
  }

  static Future<dynamic> removeFavorite(int productId, String token) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/favorite/$productId'),
      headers: getHeaderWithToken(token),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return response;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to delete favorite: ${jsonDecode(response.body)}');
    }
  }

}
