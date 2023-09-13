import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/molecules/appbar.dart';
import 'package:frontend/molecules/top_bar_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:frontend/molecules/horizontal_list.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:frontend/molecules/plus_nav_bar.dart';

import '../product.dart';


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
    'productName': '남양)프렌치카푸치노200ml',
    'price': 2700,
    'filename': 'assets/images/coffee.png',
    'badge': '1+1',
    'category': 1,
    'favoriteCount': 42,
    'weight': 200,
    'kcal': 150,
    'carb': 20.5,
    'protein': 10.0,
    'fat': 5.0,
    'sodium': 300.0,
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
      ChartData('kcal', 150 / StandardDetail['kcal'], Colors.grey),
      ChartData('carb', 20.5 / StandardDetail['carb'], Colors.red),
      ChartData('protein', 10 / StandardDetail['protein'], Colors.green),
      ChartData('fat', 5.0 / StandardDetail['fat'], Colors.blue),
      ChartData('sodium', 300 / StandardDetail['sodium'], Colors.orange),
    ];

    kcalData = [
      ChartData('kcal', 150 / StandardDetail['kcal'], Colors.red)
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
                padding: EdgeInsets.only(left: 20),
                child: Image.asset(
                  'assets/images/coffee.jpg',
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
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 250,
                        color: Colors.grey[200],

                        child: Container(
                          child: SfCircularChart(
                            series: <CircularSeries>[
                              RadialBarSeries<ChartData, String>(
                                trackColor: Colors.white,
                                dataSource: chartData,
                                pointColorMapper:(ChartData data, _) => data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 250,
                        color: Colors.grey[200],

                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                leading: Icon(Icons.circle, color: Colors.red),
                                title: Text('순탄수 : ' + '${carbRatio.toStringAsFixed(2)}%'),
                              ),
                              ListTile(
                                leading: Icon(Icons.circle, color: Colors.green),
                                title: Text('단백질 : ' '${proteinRatio.toStringAsFixed(2)}%'),
                              ),
                              ListTile(
                                leading: Icon(Icons.circle, color: Colors.blue),
                                title: Text('지방 : '+'${fatRatio.toStringAsFixed(2)}%'),
                              ),
                              ListTile(
                                leading: Icon(Icons.circle, color: Colors.orange),
                                title: Text('나트륨 : '+'${sodiumRatio.toStringAsFixed(2)}%'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Container(
                            height: 20,
                            child: Text('순탄수'),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            height: 10,
                            width: 90,
                            color: Colors.grey, // 회색 배경
                            child: FractionallySizedBox(
                              widthFactor: proteinRatio, // 비율 설정
                              alignment: Alignment.centerLeft, // 왼쪽 정렬
                              child: Container(
                                color: Colors.green, // 초록색
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 20,
                            child: Text('${ProductDetail['carb']}' + ' / ' + '${StandardDetail['carb']}' + 'g'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Container(
                            height: 20,
                            child: Text('단백질'),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            height: 10,
                            width: 90,
                            color: Colors.grey, // 회색 배경
                            child: FractionallySizedBox(
                              widthFactor: proteinRatio, // 비율 설정
                              alignment: Alignment.centerLeft, // 왼쪽 정렬
                              child: Container(
                                color: Colors.green, // 초록색
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 20,
                            child: Text('${ProductDetail['protein']}' + ' / ' + '${StandardDetail['protein']}' + 'g'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Container(
                            height: 20,
                            child: Text('지방'),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            height: 10,
                            width: 90,
                            color: Colors.grey, // 회색 배경
                            child: FractionallySizedBox(
                              widthFactor: proteinRatio, // 비율 설정
                              alignment: Alignment.centerLeft, // 왼쪽 정렬
                              child: Container(
                                color: Colors.green, // 초록색
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 20,
                            child: Text('${ProductDetail['fat']}' + ' / ' + '${StandardDetail['fat']}' + 'g'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 150,
                color: Colors.grey[200],
                child: Center(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10.0), // 원하는 모서리 둥글기 값 설정
                        ),
                        child: Container(
                          child: Center(

                            child: Text(
                              ' "${StandardDetail['kcal'] - ProductDetail['kcal']}kcal를 더 먹을 수 있어요" ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,// 흰색으로 설정
                              ),
                            ),
                          ),

                        ),
                      ),
                    ),
                  ),
                ),
              ),
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