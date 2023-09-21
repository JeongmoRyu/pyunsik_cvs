import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  await getList();
}
Future<void> getList() async {
  //필터링 쿼리 적용한 rest api 호출
  final String apiUrl = "http://j9a505.p.ssafy.io:8881/api/product/";

  var queryParams = {
    'price' : ['100', '1000'],
  };
  Future<List<dynamic>> result = fetchData(queryParams);
  print(result);
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
    final List<dynamic> data = json.decode(body);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}