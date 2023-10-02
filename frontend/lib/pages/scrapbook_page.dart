import 'package:flutter/material.dart';
import 'package:frontend/atom/product_image.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:frontend/models/user.dart';

import '../atom/loading.dart';
import '../models/product_simple.dart';
import '../molecules/top_bar_main.dart';
import '../util/product_api.dart';


class ScrapBook extends StatefulWidget {
  const ScrapBook({Key? key}) : super(key: key);

  @override
  _ScrapBookState createState() => _ScrapBookState();
}

class _ScrapBookState extends State<ScrapBook> {
  // 샘플 데이터
  List<Map<String, dynamic>> favorites = [
    {'productId': 'Long1', 'name': '불닭볶음면', 'price': '1800', 'filename': 'String1', 'badge': 'String1', 'imagePath': 'assets/images/ramen.PNG'},
    {'productId': 'Long2', 'name': 'Item2', 'price': '4000', 'filename': 'String2', 'badge': 'String2', 'imagePath': 'assets/images/wip.jpg'},
    {'productId': 'Long3', 'name': 'Item3', 'price': '4000', 'filename': 'String3', 'badge': 'String3', 'imagePath': 'assets/images/wip.jpg'},
    {'productId': 'Long4', 'name': 'Item4', 'price': '4000', 'filename': 'String4', 'badge': 'String4', 'imagePath': 'assets/images/wip.jpg'},
    {'productId': 'Long4', 'name': 'Item5', 'price': '4000', 'filename': 'String4', 'badge': 'String4', 'imagePath': 'assets/images/wip.jpg'},
    {'productId': 'Long4', 'name': 'Item6', 'price': '4000', 'filename': 'String4', 'badge': 'String4', 'imagePath': 'assets/images/wip.jpg'},
    {'productId': 'Long4', 'name': 'Item7', 'price': '4000', 'filename': 'String4', 'badge': 'String4', 'imagePath': 'assets/images/wip.jpg'},
    {'productId': 'Long4', 'name': 'Item8', 'price': '4000', 'filename': 'String4', 'badge': 'String4', 'imagePath': 'assets/images/wip.jpg'},
    {'productId': 'Long4', 'name': 'Item9', 'price': '4000', 'filename': 'String4', 'badge': 'String4', 'imagePath': 'assets/images/wip.jpg'},
    {'productId': 'Long4', 'name': 'Item10', 'price': '4000', 'filename': 'String4', 'badge': 'String4', 'imagePath': 'assets/images/wip.jpg'},

  ];

  List<Map<String, dynamic>> combinations = [
    {
      'name': '불닭볶음면과 콘치즈',
      'total_price': '13500',
      'total_kcal': '1850',
      'total_carb': '5000',
      'total_protein': '5000',
      'total_fat': '5000',
      'total_sodium': '5000',
      'CombinationItems': [
        {'productId': 'Long5', 'name': 'Item5', 'price': '4000', 'imagePath': 'assets/images/ramen.PNG', 'amounts': '500'},
        {'productId': 'Long6', 'name': 'Item6', 'price': '4000', 'imagePath': 'assets/images/wip.jpg', 'amounts': '500'},
        {'productId': 'Long7', 'name': 'Item7', 'price': '4000', 'imagePath': 'assets/images/wip.jpg', 'amounts': '500'},
      ]
    },
    {
      'name': 'Combination2',
      'total_price': '20000',
      'total_kcal': '5000',
      'total_carb': '5000',
      'total_protein': '5000',
      'total_fat': '5000',
      'total_sodium': '5000',
      'CombinationItems': [
        {'productId': 'Long8', 'name': 'Item8', 'price': '4000', 'imagePath': 'assets/images/wip.jpg', 'amounts': '500'},
        {'productId': 'Long9', 'name': 'Item9', 'price': '4000', 'imagePath': 'assets/images/wip.jpg', 'amounts': '500'},
        {'productId': 'Long10', 'name': 'Item10', 'price': '4000', 'imagePath': 'assets/images/wip.jpg', 'amounts': '500'},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();

    if (user.accessToken.isNotEmpty) {
      return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TopBarMain(appBar: AppBar(),),// AppBar에 표시할 제목
        body: Column(
          children: [
            SizedBox(
              height: 100,
              child: Center( // 텍스트를 중앙 정렬합니다.
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '스크랩북',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      user.accessToken.isNotEmpty ? '${user.nickname}' : '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            ),

            TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: '즐겨찾기' + '(${favorites.length})'),
                Tab(text: '저장된 조합' + '(${combinations.length})'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Favorites 탭의 내용
                  FutureBuilder(
                    future: ProductApi.getFavorites(user.accessToken),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ProductSimple> favoriteList = snapshot.data!
                            .map((data) => ProductSimple.fromJson(data as Map<String, dynamic>))
                            .toList();
                        return ListView.builder(
                          itemCount: favoriteList.length,
                          itemBuilder: (context, index) {
                            final item = favoriteList[index];
                            return InkWell(
                              onTap: () {
                                context.push('/detail', extra: 1);
                              },
                              child: ListTile(
                                title: Text(item.productName),
                                subtitle: Text('${item.price}원'),
                                leading: ProductImage(filename: item.filename),
                                // 원하는 정보를 표시
                              ),
                            );
                          },
                        );
                      }
                      if (snapshot.hasError) {
                        print(snapshot.toString());
                        return Text('${snapshot.error}');
                      }
                      return Loading();
                    }
                  ),

                  // Combinations 탭의 내용
                  ListView.builder(
                    itemCount: combinations.length,
                    itemBuilder: (context, index) {
                      final combination = combinations[index];

                      return InkWell(
                        onTap: () {
                          context.push('/combination_detail');
                        },
                        child: ListTile(
                          title: Text(combination['name']),
                          subtitle: Text('총 칼로리 : ' + '${combination['total_kcal']}' + 'kcal'),
                          leading: Image.asset(combination['CombinationItems'][0]['imagePath']),
                        ),
                      );
                      },
                    ),
                  ],
                ),
              ),
                ],
              ),
            ),

    );
    } else
      return Scaffold(
        appBar: TopBarMain(appBar: AppBar(),),// AppBar에 표시할 제목
        body: Column(
        children: [
          Container(
            height: 100,
            child: Center( // 텍스트를 중앙 정렬합니다.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '스크랩북',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user.accessToken.isNotEmpty ? '${user.nickname}' : '',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
          ),
          Text('로그인이 필요한 기능입니다.'),
          SizedBox(height: 10,),
          Center(
            child: FilledButton(
              onPressed: () {
                context.go('/login');
              },
              child: Text(
                '로그인',
              ),
            ),
          ),
        ]
      )
    );

  }
}
