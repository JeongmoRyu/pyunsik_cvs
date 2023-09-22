import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import 'package:frontend/molecules/temp_chart.dart';
import 'package:frontend/models/productdetail.dart';
import 'package:frontend/molecules/horizontal_list.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:frontend/molecules/plus_nav_bar.dart';
import '../models/product.dart';

class ApiTemp extends StatefulWidget {
  @override
  _ApiTempState createState() => _ApiTempState();
}

class _ApiTempState extends State<ApiTemp> {
  List<Product> testList = [
    new Product(1, 'test product short', '', 1800),
    new Product(2, 'test product middle middle', '', 39900),
    new Product(3, 'test product long long long long long long long', '', 1498000),
    new Product(4, 'test product short', '', 1800),
    new Product(5, 'test product short', '', 1800),
    new Product(6, 'test product short', '', 1800),
    new Product(7, 'test product short', '', 1800),
    new Product(8, 'test product short', '', 1800),
  ];

  Future<ProductDetail> fetchData() async {
    final String apiUrl = "http://j9a505.p.ssafy.io:8881/api/product/1";

    final headers = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };

    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = json.decode(body);
      if (data['filename'] == null) {
        data['filename'] = 'none';
      }
      return ProductDetail.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TopBarSub(appBar: AppBar()),
        body: FutureBuilder<ProductDetail>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 데이터 로딩 중인 경우 로딩 스피너를 표시
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // 데이터 로딩 중 오류가 발생한 경우 오류 메시지 표시
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // 데이터 로딩이 완료된 경우 화면에 데이터 표시
              final ProductDetail productDetail = snapshot.data!;
              // final ProductDetail = productdetail;

              return ListView(
                children: [
                  if (productDetail.filename != 'none')
                    Image.network(
                      '${productDetail.filename}',
                      fit: BoxFit.cover,
                    )
                  else
                    Image.asset(
                      'assets/images/wip.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  SizedBox(height: 10,),
                  Container(
                    height: productDetail.productName.length > 20 ? 55 : 25,
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ' ${productDetail.productName}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 25,
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            if (productDetail.badge != null)
                              TextSpan(
                                text: ' ${productDetail.badge}',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            TextSpan(
                              text: ' ${productDetail.price} 원',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: 48,
                    child: TabBar(
                      labelColor: Colors.black,
                      tabs: [
                        Tab(text: '상세정보'),
                        Tab(text: '상품리뷰'),
                      ],
                    ),
                  ),
                  Container(
                    height: 480,
                    child: TabBarView(
                      children: [
                        TempChart(productDetail: productDetail),
                        ListView.builder(
                          itemCount: productDetail.comments.length,
                          itemBuilder: (context, index) {
                            final Comment comment = productDetail.comments[index];

                            return InkWell(
                              onTap: () {},
                              child: ListTile(
                                title: Text(comment.nickname),
                                subtitle: Text('${comment.content}'),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 350, // 원하는 높이로 설정
                    child: HorizontalList(title: '오늘의 추천 상품', productList: testList,),
                  ),
                  CustomBox(),
                ],
              );
            }
          },
        ),
        // bottomNavigationBar: PlusNavBar(count: 1, productDetail: productDetail),
      ),
    );
  }
}
