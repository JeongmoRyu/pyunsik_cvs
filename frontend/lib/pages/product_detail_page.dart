import 'package:flutter/material.dart';
import 'package:frontend/models/product_simple.dart';
import 'package:frontend/molecules/combination_chart.dart';
import 'package:frontend/molecules/promotion_badge_list.dart';
import 'package:frontend/util/product_api.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import 'package:frontend/molecules/horizontal_list.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:frontend/molecules/plus_nav_bar.dart';

import 'package:frontend/util/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../atom/product_image.dart';
import '../models/filter.dart';
import '../models/product_detail.dart';
import '../models/user.dart';

class ProductDetailPage extends StatelessWidget {
  static NumberFormat format = NumberFormat.decimalPattern('en_us');

  final int productId;

  const ProductDetailPage({super.key, required this.productId});
  
  @override
  Widget build(BuildContext context) {
    const tag = '카테고리';
    var filter = context.watch<Filter>();
    var user = context.watch<User>();

    return WillPopScope(
      onWillPop: () async {
        user.checkChange();
        return true;
      },
      child: DefaultTabController(
          length: 2,
          child: FutureBuilder<ProductDetail>(
            future: ProductApi.getProductDetail(user.accessToken, productId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // 데이터 로딩 중인 경우 로딩 스피너를 표시
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // 데이터 로딩 중 오류가 발생한 경우 오류 메시지 표시
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                // 데이터 로딩이 완료된 경우 화면에 데이터 표시
                final ProductDetail productDetail = snapshot.data!;
                productDetail.productId = productId;
                return Scaffold(
                  appBar: TopBarSub(appBar: AppBar()),
                  body: ListView(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ProductImage(filename: productDetail.filename,)),
                          PromotionBadgeList(
                            product: ProductSimple(
                                productId: productId,
                                price: productDetail.price,
                                filename: productDetail.filename,
                                productName: productDetail.productName,
                                convenienceCode: productDetail.convenienceCode,
                                promotionCode: productDetail.promotionCode
                            ),
                            isLarge: true
                          )
                        ]
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Constants.horizontalPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                filter.addChoice(
                                    tag, getCategory(productDetail.category));
                                context.go('/list/filtered');
                              },
                              child: Text(
                                getCategory(productDetail.category),
                                style: const TextStyle(
                                    fontSize: 12, color: Constants.darkGrey),
                              ),
                            ), //카테고리
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: [
                              Expanded(
                                child: Text(
                                  productDetail.productName,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                              )
                            ]),
                            SizedBox(
                              height: 10,
                            ),
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
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 48,
                        child: TabBar(
                          labelColor: Colors.black,
                          tabs: [
                            Tab(text: '영양정보'),
                            Tab(
                                text:
                                '리뷰 (${format.format(productDetail.comments.length)})'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 350,
                        child: TabBarView(
                          children: [
                            CombinationChart(totalKcal: productDetail.kcal,
                                totalProtein: productDetail.protein,
                                totalFat: productDetail.fat,
                                totalCarb: productDetail.carb,
                                totalSodium: productDetail.sodium
                            ),
                            ListView.builder(
                              itemCount: productDetail.comments.length,
                              itemBuilder: (context, index) {
                                final Comment comment =
                                productDetail.comments[index];

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
                      CustomBox(),
                      Container(
                        height: 350, // 원하는 높이로 설정
                        child: HorizontalList(
                          title: '다른 사용자가 함께 본 상품',
                          type: 'user',
                        ),
                      ),
                      CustomBox(),
                    ],
                  ),
                  bottomNavigationBar: PlusNavBar(count: productDetail.favoriteCount, productDetail: productDetail),
                );
              }
            },
          )),
    );
  }

  String getCategory(int index) {
    var category = ['간편식사', '즉석요리', '과자', '아이스크림', '식품', '음료', '생활용품'];
    return category[index - 1];
  }
}
