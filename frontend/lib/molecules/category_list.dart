import 'package:flutter/material.dart';
import 'package:frontend/atom/button/category_button.dart';
import 'package:go_router/go_router.dart';


class CategoryList extends StatelessWidget {
  const CategoryList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        child: ListView(
            itemExtent: 70.0,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            CategoryButton(
                onPressed: () {
                  context.go('/product_filtered');
                },
                imageUrl: 'assets/images/gs_logo.png',
                name: 'GS'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/scrapbook');
                },
                imageUrl: 'assets/images/cu_logo.png',
                name: 'CU'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_list');
                },
                imageUrl: 'assets/images/711_logo2.jpeg',
                name: '세븐일레븐'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/side_scroll');
                },
                imageUrl: 'assets/images/ministop_logo.png',
                name: '미니스톱'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/login');
                },
                imageUrl: 'assets/images/gs_logo.png',
                name: 'GS'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/signup');
                },
                imageUrl: 'assets/images/cu_logo.png',
                name: 'CU'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_detail');
                },
                imageUrl: 'assets/images/711_logo2.jpeg',
                name: '세븐일레븐'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/');
                },
                imageUrl: 'assets/images/ministop_logo.png',
                name: '미니스톱'
            ),
          ]
        ),
    //   child :CarouselSlider(
    //   options: CarouselOptions(
    //     height: 70,
    //     autoPlay: false,
    //     enlargeCenterPage: false,
    //     viewportFraction: 0.2,
    //     aspectRatio: 1 / 1,
    //     enableInfiniteScroll: false,
    //     initialPage: 2,
    //
    //     // finalPage: -2
    //
    //   ),
    //   items: [
    //
    //     GsButton(
    //       onPressed: () {
    //         context.go('/');
    //       },
    //     ),
    //     CuButton(
    //       onPressed: () {
    //         context.go('/product_filtered_page');
    //       },
    //     ),
    //     MinistopButton(
    //       onPressed: () {
    //         context.go('/scrapbook_page');
    //       },
    //     ),
    //     SevenElevenButton(
    //       onPressed: () {
    //         context.go('/product_list_page');
    //       },
    //     ),
    //     GsButton(
    //       onPressed: () {
    //         context.go('/side_scroll_page');
    //       },
    //     ),
    //     CuButton(
    //       onPressed: () {
    //         context.go('/login_page');
    //       },
    //     ),
    //     MinistopButton(
    //       onPressed: () {
    //         context.go('/scrapbook_page');
    //       },
    //     ),
    //     SevenElevenButton(
    //       onPressed: () {
    //         context.go('/product_list_page');
    //       },
    //     ),
    //
    //   ],
    // )
    );
  }
}
