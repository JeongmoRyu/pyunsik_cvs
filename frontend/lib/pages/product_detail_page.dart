import 'package:flutter/material.dart';
import 'package:frontend/molecules/top_bar_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:frontend/molecules/horizontal_list.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:frontend/molecules/plus_nav_bar.dart';
import 'package:frontend/molecules/temp_chart.dart';
import 'package:frontend/molecules/temp_chart_in_all.dart';

import '../models/product.dart';


class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
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

  Map<String, dynamic> ProductDetail = {
    'productName': '불닭볶음면',
    'price': 1800,
    'filename': 'assets/images/ramen.PNG',
    'badge': '2+1',
    'category': 2,
    'favoriteCount': 42,
    'weight': 200,
    'kcal': 425,
    'carb': 63,
    'protein': 9,
    'fat': 15,
    'sodium': 950.0,
    'comments': [
      {
        'nickname': 'abc',
        'content': '좋아요!',
        'createdAt': '2023-09-15',
      },
      {
        'nickname': 'abcd',
        'content': '맛있어요!',
        'createdAt': '2023-09-16',
      },
      {
        'nickname': 'efghj',
        'content': '너무 매워요 ㅠㅠㅠ',
        'createdAt': '2023-09-17',
      },
    ],
  };

  Map<String, dynamic> StandardDetail = {
    'kcal': 2500,
    'carb': 130,
    'protein': 60,
    'fat': 51.0,
    'sodium': 2000.0,
  };

  double kcalRatio = 0.0;
  double proteinRatio = 0.0;
  double fatRatio = 0.0;
  double sodiumRatio = 0.0;
  double carbRatio = 0.0;

  List<ChartData> chartData = [];
  List<ChartData> kcalData = [];


  @override
  void initState() {
    super.initState();
    kcalRatio = ProductDetail['kcal'] / StandardDetail['kcal'];
    proteinRatio = ProductDetail['protein'] / StandardDetail['protein'];
    fatRatio = ProductDetail['fat'] / StandardDetail['fat'];
    sodiumRatio = ProductDetail['sodium'] / StandardDetail['sodium'];
    carbRatio = ProductDetail['carb'] / StandardDetail['carb'];

    chartData = [
      ChartData('kcal', ProductDetail['kcal'] / StandardDetail['kcal'], Colors.grey),
      ChartData('carb', ProductDetail['carb'] / StandardDetail['carb'], Colors.red),
      ChartData('protein', ProductDetail['protein'] / StandardDetail['protein'], Colors.green),
      ChartData('fat', ProductDetail['fat'] / StandardDetail['fat'], Colors.blue),
      ChartData('sodium', ProductDetail['sodium'] / StandardDetail['sodium'], Colors.orange),
    ];

    kcalData = [
      ChartData('kcal', ProductDetail['kcal'] / StandardDetail['kcal'], Colors.red)
    ];


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBarMain(appBar: AppBar(),),
        body: ListView(
            children: [
              Container(
                width: double.infinity,
                height: 350,
                child: Image.asset(
                  'assets/images/ramen.PNG',
                  fit: BoxFit.cover,
                ),
              ),
              // CustomBox(),
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
              TempChart(),
              CustomBox(),
              SizedBox(height: 10,),
              Container(
                height: 350, // 원하는 높이로 설정
                child: HorizontalList(title: '오늘의 추천 상품', productList: testList,),
              ),
              CustomBox(),



              // SizedBox(height: 10,),

          ],
        ),
        bottomNavigationBar: PlusNavBar(),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
// class kcalData {
//   kcalData(this.x, this.y, this.color);
//   final String x;
//   final double y;
//   final Color color;
// }
// class proteinData {
//   proteinData(this.x, this.y, this.color);
//   final String x;
//   final double y;
//   final Color color;
// }
// class fatData {
//   fatData(this.x, this.y, this.color);
//   final String x;
//   final double y;
//   final Color color;
// }
// class sodiumData {
//   sodiumData(this.x, this.y, this.color);
//   final String x;
//   final double y;
//   final Color color;
// }