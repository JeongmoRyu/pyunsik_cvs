import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyValue = '';
  List<String> searchDataList = [];
  List<String> relatedDataList = [];
  int maxSearchDataCount = 10;
  int maxrelatedDataList = 10;

  @override
  void initState() {
    super.initState();
    keyValue = '';
  }

  void saveSearchData(String data) {
    if (searchDataList.length >= maxSearchDataCount) {
      searchDataList.removeAt(0);
    }
    searchDataList.add(data);
  }

  Future<Map<String, dynamic>> fetchData() async {
    final String apiUrl = "http://j9a505.p.ssafy.io:8080/api/product/1";

    final headers = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };

    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = json.decode(body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(60),
                ],
                onSubmitted: (value) {
                  setState(() {
                    keyValue = value;
                    saveSearchData(value);
                  });
                },
                onChanged: (value) {
                  setState(() {
                    keyValue = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(241, 241, 241, 1.0),
                  prefixIcon: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              context.go('/scrapbook');
            },
            icon: Icon(Icons.bookmark_outline),
          ),
          IconButton(
            onPressed: () {
              context.go('/cart');
            },
            icon: Icon(Icons.interests_outlined),
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final AllProduct = snapshot.data as Map<String, dynamic>;

            return ListView(
              children: [
                Container(
                  height: 30,
                  child: Text('$keyValue'),
                ),
                if (keyValue.isNotEmpty)
                  Container(
                    height: 550,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  '+'$keyValue ' + ' 와 관련한 데이터 :'),
                        SizedBox(height: 10,),
                        Column(
                          children: relatedDataList.map((data) {
                            return ListTile(
                              leading: Icon(Icons.search),
                              title: Text(data),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    // Text('$AllProduct'),
                  )
                else
                  Container(
                    height: 550,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  ' + '최근 검색 데이터 :'),
                        SizedBox(height: 10,),
                        Column(
                          children: searchDataList.map((data) {
                            return ListTile(
                              leading: Icon(Icons.search),
                              title: Text(data),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
