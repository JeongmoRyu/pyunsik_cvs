import 'package:flutter/material.dart';
import 'package:frontend/atom/product_image.dart';
import 'package:frontend/models/combination_simple.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:frontend/models/user.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

import '../atom/loading.dart';
import '../models/product_simple.dart';
import '../molecules/top_bar_main.dart';
import '../util/product_api.dart';


class ScrapBook extends StatelessWidget {
  const ScrapBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    if (user.accessToken.isNotEmpty) {
      return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TopBarMain(appBar: AppBar(),),// AppBar에 표시할 제목
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('\'뒤로\'버튼을 한번 더 누르시면  종료됩니다.'),
          ),
          child: Column(
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        user.accessToken.isNotEmpty ? '${user.nickname}' : '',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const TabBar(
                tabs: [
                  Tab(text: '상품'),
                  Tab(text: '조합'),
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
                          if (favoriteList.isEmpty) {
                            return const Center(
                              child: Text('상품이 없습니다'),
                            );
                          }
                          return ListView.builder(
                            itemCount: favoriteList.length,
                            itemBuilder: (context, index) {
                              final item = favoriteList[index];
                              return InkWell(
                                onTap: () {
                                  context.push('/detail', extra: item.productId);
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
                    FutureBuilder(
                        future: ProductApi.getCombinationList(user.accessToken),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<CombinationSimple> combinationList = snapshot.data!;
                            if (combinationList.isEmpty) {
                              return const Center(
                                child: Text('조합이 없습니다'),
                              );
                            }
                            return ListView.builder(
                              itemCount: combinationList.length,
                              itemBuilder: (context, index) {
                                final combination = combinationList[index];
                                return InkWell(
                                  onTap: () {
                                    context.push('/combination_detail', extra: combination.combinationId);
                                  },
                                  child: ListTile(
                                    title: Text(combination.combinationName),
                                    subtitle: Text('총 칼로리 : ${combination.totalKcal}kcal'),
                                    leading: ProductImage(filename: '',),
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
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    } else {
      return Scaffold(
        appBar: TopBarMain(appBar: AppBar(),),// AppBar에 표시할 제목
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('정말 종료하신다면 뒤로 가기 버튼을 다시'),
          ),
          child: Column(
            children: [
              Container(
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
                        style: const TextStyle(
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
                    context.push('/login');
                  },
                  child: Text(
                    '로그인',
                  ),
                ),
              ),
            ]
          ),
        )
      );
    }
  }
}
