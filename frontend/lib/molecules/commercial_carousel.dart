import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';



class CommercialCarousel extends StatelessWidget {
  const CommercialCarousel({Key? key});

  static const List<Map<String, String>> imageList = [
    {
      'image':'assets/images/main_event.png',
      'url':''
    },
    {
      'image':'assets/images/event1.png',
      'url':'https://cu.bgfretail.com/brand_info/news_view.do?category=brand_info&depth2=5&idx=967'
    },
    {
      'image':'assets/images/event2.png',
      'url':'https://cu.bgfretail.com/brand_info/news_view.do?category=brand_info&depth2=5&idx=961'
    },
    {
      'image':'assets/images/event3.jpg',
      'url':'http://gs25.gsretail.com/gscvs/ko/customer-engagement/event/detail/publishing?pageNum=2&eventCode=8835382005280'
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
        child : CarouselSlider(
          options: CarouselOptions(
            height: 200, // 슬라이더 높이 조절
            autoPlay: true, // 자동 슬라이드
            autoPlayInterval: Duration(seconds: 7), // 자동 슬라이드 간격
            enlargeCenterPage: true, // 현재 페이지 확대
            viewportFraction: 1.0, // 현재 화면에 표시될 페이지의 비율을 1로 설정

          ),
          items: imageList.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    if (item['url'] == '') {
                      return;
                    }
                    _launchUrl(item['url']!
                    );},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.asset(item['image']!, fit: BoxFit.cover),
                  ),
                );
              },
            );
          }).toList(),
        )
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication,)) {
      throw Exception('Could not launch $url');
    }
  }
}
