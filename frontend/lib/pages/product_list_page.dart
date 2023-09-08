import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/molecules/ranking.dart';
import 'package:frontend/molecules/appbar.dart';
import 'package:frontend/molecules/category_list.dart';
import 'package:frontend/molecules/horizontal_list.dart';

class FirstList extends StatelessWidget {
  const FirstList({Key? key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          SizedBox(height: 20), // 간격 추가
          CategoryCarousel(),
          SizedBox(height: 10), // 간격 추가
          Container(
            height: 250, // 원하는 높이로 설정
            child: SideScrollEffect(),
          ),
          SizedBox(height: 10), // 간격 추가
          Container(
            width: 400,
            child: Rank(),
          ),
        ],
      ),
    );
  }
}



