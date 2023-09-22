import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:frontend/util/network.dart';



class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyValue = '';
  List<String> searchDataList = [];
  List<String> relatedDataList = [];
  int maxSearchDataCount = 8;
  int maxrelatedDataList = 8;
  List<dynamic> AllProduct = []; // AllProduct 변수를 추가

  @override
  void initState() {
    super.initState();
    keyValue = '';
    loadSearchData();
    fetchAndSetData();
  }

  Future<void> fetchAndSetData() async {
    try {
      final data = await fetchData();
      setState(() {
        AllProduct = data;
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> searchRelatedData() async {
    if (keyValue.isEmpty) {
      return; // 검색어가 비어있으면 아무 작업도 수행하지 않음
    }
    List<String> results = [];

    for (var product in AllProduct) {
      String productName = product['productName'];
      if (productName.toLowerCase().contains(keyValue.toLowerCase())) {
        results.add(productName);
      }
      if (results.length >= maxrelatedDataList) {
        break;
      }
    }

    // 찾은 데이터를 relatedDataList에 추가
    setState(() {
      relatedDataList = results;
    });
  }


  void saveSearchData(String data) async {
    if (searchDataList.length >= maxSearchDataCount) {
      searchDataList.removeAt(0);
    }
    searchDataList.add(data);

    // SharedPreferences에 검색어 데이터 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('keyword', searchDataList);
  }

  void loadSearchData() async {
    // SharedPreferences에서 검색어 데이터 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchDataList = prefs.getStringList('keyword') ?? [];

    // 최대 검색어 개수를 초과하면 삭제
    if (searchDataList.length > maxSearchDataCount) {
      searchDataList = searchDataList.sublist(searchDataList.length - maxSearchDataCount);
    }
  }

  Future<List<dynamic>> fetchData() async {
    final String apiUrl = "${Network.apiUrl}" + "product/";

    final response = await http.get(Uri.parse(apiUrl), headers: Network.getHeader(''));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final List<dynamic> data = json.decode(body);
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
                  LengthLimitingTextInputFormatter(50),
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
                  searchRelatedData();

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
            final AllProduct = snapshot.data as List<dynamic>;

            return ListView(
              children: [
                // Text('$AllProduct'),

                if (keyValue.isNotEmpty)
                  Container(
                    height: 550,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                  )
                else
                  Container(
                    height: 550,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  ' + '최근 검색어'),
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
