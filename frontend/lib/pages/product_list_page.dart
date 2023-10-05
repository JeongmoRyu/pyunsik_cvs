import 'package:flutter/material.dart';
import 'package:frontend/molecules/top_bar_main.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:frontend/molecules/ranking.dart';
import 'package:frontend/molecules/category_list_cvs.dart';
import 'package:frontend/molecules/horizontal_list.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

import 'package:frontend/molecules/category_list_genre.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key});


  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    return Scaffold(
      appBar: TopBarMain(appBar: AppBar(),),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('\'뒤로\'버튼을 한번 더 누르시면  종료됩니다.'),
        ),
        child: ListView(
          children: [
            CategoryList(),
            CategoryGenreList(),
            CustomBox(),
            HorizontalList(title: user.accessToken.isEmpty ?
            '인기 상품' : '${user.nickname}님이 좋아할만한 상품', type: 'user',),
            CustomBox(),
            Ranking(),
          ],
        ),
      ),
    );
  }
}



