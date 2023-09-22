import 'package:flutter/material.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import 'package:frontend/util/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:frontend/molecules/horizontal_list.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:frontend/molecules/plus_nav_bar.dart';
import 'package:frontend/molecules/temp_chart.dart';
import 'package:provider/provider.dart';

import '../models/filter.dart';
import '../models/product.dart';


class TempProductDetailPage extends StatefulWidget {
  const TempProductDetailPage({Key? key}) : super(key: key);

  @override
  _TempProductDetailPageState createState() => _TempProductDetailPageState();
}

class _TempProductDetailPageState extends State<TempProductDetailPage> {
  static NumberFormat format = NumberFormat.decimalPattern('en_us');

  List<Product> testList = [
    Product(1, 'test product short', '', 1800),
    Product(2, 'test product middle middle', '', 39900),
    Product(3, 'test product long long long long long long long', '', 1498000),
    Product(4, 'test product short', '', 1800),
    Product(5, 'test product short', '', 1800),
    Product(6, 'test product short', '', 1800),
    Product(7, 'test product short', '', 1800),
    Product(8, 'test product short', '', 1800),
  ];

  Map<String, dynamic> productDetail = {
    'productName': '불닭볶음면불닭볶음면불닭볶음면불닭볶음면불닭볶음면불닭볶음면',
    'price': 1800,
    'filename': 'assets/images/ramen.PNG',
    'badge': '2+1',
    'category': 2,
    'favoriteCount': 42424,
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
    kcalRatio = productDetail['kcal'] / StandardDetail['kcal'];
    proteinRatio = productDetail['protein'] / StandardDetail['protein'];
    fatRatio = productDetail['fat'] / StandardDetail['fat'];
    sodiumRatio = productDetail['sodium'] / StandardDetail['sodium'];
    carbRatio = productDetail['carb'] / StandardDetail['carb'];

    kcalData = [
      ChartData('kcal', productDetail['kcal'] / StandardDetail['kcal'], Colors.red)
    ];
  }

  @override
  Widget build(BuildContext context) {
    const tag = '카테고리';
    var filter = context.watch<Filter>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TopBarSub(appBar: AppBar()), // AppBar에 표시할 제목
        body: ListView(
          children: [
            Image.asset(
              'assets/images/ramen.PNG',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Constants.horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      filter.addChoice(
                          tag,
                          getCategory(productDetail['category'])
                      );
                      context.go('/list/filtered');
                    },
                    child: Text(
                      getCategory(productDetail['category']),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Constants.darkGrey
                      ),
                    ),
                  ), //카테고리
                  const SizedBox(height: 10,),
                  Row(
                      children: [
                        Expanded(
                          child: Text(
                            productDetail['productName'],
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 150,)
                      ]
                  ),
                  SizedBox(height: 10,),
                  Text(
                    '${format.format(productDetail['price'])}원',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 48,
              child: TabBar(
                tabs: [
                  Tab(text: '영양정보'),
                  Tab(
                      text: '리뷰 (${format.format(productDetail['comments'].length)})'
                  ),
                ],
              ),
            ),
            Container(
              height: 480,
              child: TabBarView(
                children: [
                  // TempChart(productDetail: productDetail),
                  ListView.builder(
                    itemCount: productDetail['comments'].length,
                    itemBuilder: (context, index) {
                      final comment = productDetail['comments'][index];

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

            CustomBox(),
            SizedBox(height: 10,),
            Container(
              height: 350,
              child: HorizontalList(title: '오늘의 추천 상품', productList: testList,),
            ),
            CustomBox(),
          ],
        ),
        // bottomNavigationBar: PlusNavBar(count: productDetail['favoriteCount'],),
      ),
    );
  }
  String getCategory(int index) {
    var category = ['간편식사', '즉석요리', '과자', '아이스크림', '식품', '음료', '생활용품'];
    return category[index - 1];
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}