import 'package:flutter/material.dart';
import 'package:frontend/util/network.dart';
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


import 'package:frontend/util/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/filter.dart';




class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  static NumberFormat format = NumberFormat.decimalPattern('en_us');
  late ProductDetail productDetail;


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
    final String apiUrl = "Network.apiUrl" + "product/1";

    final response = await http.get(Uri.parse(apiUrl), headers: Network.getHeader(''));

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
    const tag = '카테고리';
    var filter = context.watch<Filter>();


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
                                getCategory(productDetail.category)
                            );
                            context.go('/list/filtered');
                          },
                          child: Text(
                            getCategory(productDetail.category),
                            style: const TextStyle(
                                fontSize: 12,
                                color: Constants.darkGrey
                            ),
                          ),
                        ), //카테고리
                        SizedBox(height: 10,),
                        Row(
                            children: [
                              Expanded(
                                child: Text(
                                  productDetail.productName,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(width: 150,)
                            ]
                        ),
                        SizedBox(height: 10,),
                        Text(
                          '${format.format(productDetail.price)}원',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: 48,
                    child: TabBar(
                      labelColor: Colors.black,
                      tabs: [
                        Tab(text: '상세정보'),
                        Tab(
                            text: '리뷰 (${format.format(productDetail.comments.length)})'
                        ),
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
        bottomNavigationBar: PlusNavBar(count: 43),
      ),
    );
  }
  String getCategory(int index) {
    var category = ['간편식사', '즉석요리', '과자', '아이스크림', '식품', '음료', '생활용품'];
    return category[index - 1];
  }
}















  //
  //   return DefaultTabController(
  //     length: 2,
  //     child: Scaffold(
  //       appBar: TopBarSub(appBar: AppBar()), // AppBar에 표시할 제목
  //       body: ListView(
  //         children: [
  //           Image.asset(
  //             'assets/images/ramen.PNG',
  //             fit: BoxFit.cover,
  //           ),
  //           SizedBox(height: 10,),
  //
  //           Container(
  //             height: 48,
  //             child: TabBar(
  //               tabs: [
  //                 Tab(text: '영양정보'),
  //                 Tab(
  //                     text: '리뷰 (${format.format(productDetail['comments'].length)})'
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             height: 480,
  //             child: TabBarView(
  //               children: [
  //                 // TempChart(productDetail: productDetail),
  //                 ListView.builder(
  //                   itemCount: productDetail['comments'].length,
  //                   itemBuilder: (context, index) {
  //                     final comment = productDetail['comments'][index];
  //
  //                     return InkWell(
  //                       onTap: () {
  //
  //                       },
  //                       child: ListTile(
  //                         title: Text(comment['nickname']),
  //                         subtitle: Text('${comment['content']}'),
  //                       ),
  //                     );
  //                   },
  //                 )
  //               ],
  //             ),
  //           ),
  //
  //           CustomBox(),
  //           SizedBox(height: 10,),
  //           Container(
  //             height: 350,
  //             child: HorizontalList(title: '오늘의 추천 상품', productList: testList,),
  //           ),
  //           CustomBox(),
  //         ],
  //       ),
  //       bottomNavigationBar: PlusNavBar(count: productDetail['favoriteCount'],),
  //     ),
  //   );
  // }
//   String getCategory(int index) {
//     var category = ['간편식사', '즉석요리', '과자', '아이스크림', '식품', '음료', '생활용품'];
//     return category[index - 1];
//   }
// }

// class ChartData {
//   ChartData(this.x, this.y, this.color);
//   final String x;
//   final double y;
//   final Color color;
// }