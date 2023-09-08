import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/atom/button/gs_category_button.dart';
import 'package:frontend/atom/button/cu_category_button.dart';
import 'package:frontend/atom/button/ministop_category_button.dart';
import 'package:frontend/atom/button/seveneleven_category_button.dart';


class CategoryCarousel extends StatelessWidget {
  const CategoryCarousel({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child :CarouselSlider(
      options: CarouselOptions(
        height: 70,
        autoPlay: false,
        enlargeCenterPage: false,
        viewportFraction: 0.2,
        aspectRatio: 1 / 1,
        enableInfiniteScroll: false,
        initialPage: 2,

        // finalPage: -2

      ),
      items: [

        GsButton(
          onPressed: () {
            context.go('/');
          },
        ),
        CuButton(
          onPressed: () {
            context.go('/product_filtered_page');
          },
        ),
        MinistopButton(
          onPressed: () {
            context.go('/scrapbook_page');
          },
        ),
        SevenElevenButton(
          onPressed: () {
            context.go('/product_list_page');
          },
        ),
        GsButton(
          onPressed: () {
            context.go('/side_scroll_page');
          },
        ),
        CuButton(
          onPressed: () {
            context.go('/login_page');
          },
        ),
        MinistopButton(
          onPressed: () {
            context.go('/scrapbook_page');
          },
        ),
        SevenElevenButton(
          onPressed: () {
            context.go('/product_list_page');
          },
        ),
      ],
    )
    );
  }
}
