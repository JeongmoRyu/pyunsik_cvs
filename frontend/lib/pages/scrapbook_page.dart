import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/molecules/appbar.dart';
import 'package:frontend/molecules/top_bar_sub.dart';


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
    return DefaultTabController(
      length: 2, // 탭의 수
      child: Scaffold(
        appBar: TopBarSub(appBar: AppBar(),),// AppBar에 표시할 제목
        body: Column(
          children: [
            Container(
              height: 150,
              child: Center( // 텍스트를 중앙 정렬합니다.
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '스크랩북',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'ID : test계정',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        backgroundColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),

            TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: '즐겨찾기' + '(${favorites.length}개)'),
                Tab(text: '저장된 조합' + '(${combinations.length}개)'),
              ],

          ),
            Expanded(
              child: TabBarView(
                children: [
                  // Favorites 탭의 내용
                  ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final item = favorites[index];
                      return InkWell(
                        onTap: () {
                          context.go('/product_detail');
                        },
                        child: ListTile(
                          title: Text(item['name']),
                          subtitle: Text('${item['price']}' + '원'),
                          leading: Image.asset(item['imagePath']),
                          // 원하는 정보를 표시
                        ),
                      );
                    },
                  ),

                  // Combinations 탭의 내용
                  ListView.builder(
                    itemCount: combinations.length,
                    itemBuilder: (context, index) {
                      final combination = combinations[index];

                      return InkWell(
                        onTap: () {
                          context.go('/cart_page');
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
  }
}
