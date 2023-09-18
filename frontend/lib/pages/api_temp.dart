import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:frontend/molecules/top_bar_main.dart';
import 'package:frontend/molecules/temp_chart.dart';

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

  Map<String, dynamic> ProductDetail = {};

  double kcalRatio = 0.0;
  double proteinRatio = 0.0;
  double fatRatio = 0.0;
  double sodiumRatio = 0.0;
  double carbRatio = 0.0;

  List<ChartData> chartData = [];
  List<ChartData> kcalData = [];

  Map<String, dynamic> StandardDetail = {
    'kcal': 2500,
    'carb': 130,
    'protein': 60,
    'fat': 51.0,
    'sodium': 2000.0,
  };

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final String apiUrl = "http://j9a505.p.ssafy.io:8080/api/product/1";

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

      setState(() {
        ProductDetail = data;


        chartData = [
          ChartData('carb', carbRatio, Colors.grey),
          ChartData('protein', proteinRatio, Colors.black),
          ChartData('fat', fatRatio, Colors.blueGrey),
        ];

        kcalData = [
          ChartData('kcal', kcalRatio, Colors.red),
        ];

      });
      print('data: $ProductDetail');
    } else {
      print('did not work');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TopBarMain(appBar: AppBar()),
          body: ListView(
            children: [

              Container(
                height: 300,
                child: ProductDetail['filename'] != 'none'
                    ? Image.network(
                  '${ProductDetail['filename']}',
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  'assets/images/wip.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: ProductDetail['productName'].length > 20 ? 55 : 25,
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ' ${ProductDetail['productName']}',
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
                        if (ProductDetail['badge'] != null)
                          TextSpan(
                            text: ' ${ProductDetail['badge']}',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        TextSpan(
                          text: ' ${ProductDetail['price']} 원',
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
                    TempChart(productDetail: ProductDetail),
                    ListView.builder(
                      itemCount: ProductDetail['comments'].length,
                      itemBuilder: (context, index) {
                        final comment = ProductDetail['comments'][index];

                        return InkWell(
                          onTap: () {

                          },
                          child: ListTile(
                            title: Text(comment['nickname']),
                            subtitle: Text('${comment['content']}'),
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
          ),
          bottomNavigationBar: PlusNavBar(),
        ),
    );
  }
}
