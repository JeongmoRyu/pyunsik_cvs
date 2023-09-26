import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/util/constants.dart';
import 'package:frontend/util/network.dart';
import 'package:go_router/go_router.dart';

class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  late List<Map<String, dynamic>> rankList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('${Network.apiUrl}product/keyword-ranking'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      setState(() {
        rankList = List<Map<String, dynamic>>.from(data.map((item) => item as Map<String, dynamic>));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.horizontalPadding,
        vertical: Constants.verticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '실시간 인기 검색어',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: (1 / .15),
            children: rankList.map((item) {
              final int index = rankList.indexOf(item) + 1;
              final String itemName = item['keyword'] ?? '';
              return Row(
                children: [
                  SizedBox(
                    width: 22,
                    child: Text(
                      '$index',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      context.push('/detail', extra: 1);
                    },
                    child: SizedBox(
                      width: 120,
                      child: Text(
                        itemName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
