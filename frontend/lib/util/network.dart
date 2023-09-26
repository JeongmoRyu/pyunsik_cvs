import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_detail.dart';
void main() {

  Network.fetchProductList('', {'price': ['100', '1000'],}).then((result) {
    print(result);
  });
}
class Network {

  static Map<String, String> getHeader(String token) {
    return {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': '$token',
    };
  }

  static const String apiUrl = "http://j9a505.p.ssafy.io:8881/api/";

  static Future<List<dynamic>> fetchProductList(String token, Map<String, dynamic> queryParams) async {
    final uri = Uri.parse('${apiUrl}product').replace(queryParameters: queryParams);
    print('fetching data from $uri');
    final response = await http.get(uri, headers: getHeader(token));

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
    final response = await http.get(uri, headers: Network.getHeader(token));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = json.decode(body);
      return ProductDetail.fromJson(data);
    } else {
      throw Exception('Failed to load data. Status Code: ${response.statusCode}');
    }
  }


}
