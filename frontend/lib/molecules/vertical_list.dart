import 'package:flutter/material.dart';
import 'package:frontend/atom/product_card.dart';
import 'package:frontend/models/product_list.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../util/constants.dart';

class VerticalList extends StatelessWidget {
  const VerticalList({super.key,});
  Future<List<dynamic>> getList() async {
    //필터링 쿼리 적용한 rest api 호출
    final String apiUrl = "http://j9a505.p.ssafy.io:8881/api/product/";

    var queryParams = {
      'price' : ['100', '1000'],
    };
    // Future<List<dynamic>> result = fetchData(queryParams);
    // result.then((result) {
    //   print(result);
    // });
    return fetchData(queryParams);
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

  Future<List<dynamic>> fetchData2() async {
    final String apiUrl = "http://j9a505.p.ssafy.io:8881/api/product/";

    final headers = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization' : '',
    };

    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final List<dynamic> data = json.decode(body);
      print(data);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<dynamic>> productList = context.watch<ProductList>().getList();
    // Future<List<dynamic>> productList = getList();
    // productList.then((result) {
    //   print(result);
    // });
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.horizontalPadding,
          vertical: Constants.verticalPadding
      ),
      child: FutureBuilder(
        future: fetchData2(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('전체 ${snapshot.data!.length}'),
                      Spacer(),
                      Text('인기순')
                    ],
                  ),
                ),

                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 8 / 11,
                  crossAxisCount: 2,
                  children: [
                    for (var product in snapshot.data!)
                      // ProductCard(
                      //   product: product,
                      // )
                      Text(product),
                  ],
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            print(snapshot.toString());
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        }
      ),
    );
  }
}
