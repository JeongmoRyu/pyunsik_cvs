import 'package:flutter/material.dart';
import 'package:frontend/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/util/custom_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:frontend/util/network.dart';
import 'package:go_router/go_router.dart';

import '../molecules/ranking.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyValue = '';
  List<String> searchDataList = [];
  List<Map<String, dynamic>> relatedDataList = [];
  int maxSearchDataCount = 8;
  int maxrelatedDataList = 8;
  List<dynamic> AllProduct = []; // AllProduct 변수를 추가

  // TextEditingController 선언
  TextEditingController textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSearchData();
    fetchAndSetData();
  }

  @override
  void dispose() {
    // 페이지가 dispose될 때 controller도 dispose
    textFieldController.dispose();
    super.dispose();
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
      return;
    }
    List<Map<String, dynamic>> results = [];

    for (var product in AllProduct) {
      String productName = product['productName'];
      int productId = product['productId'];
      if (productName.toLowerCase().contains(keyValue.toLowerCase())) {
        results.add({
          'productName': productName,
          'productId': productId,
        });
      }
      if (results.length >= maxrelatedDataList) {
        break;
      }
    }
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

  void removeSearchData() async {
    searchDataList.clear();
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

    final response = await http.get(Uri.parse(apiUrl), headers: Network.getHeaderWithToken(''));

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
          SizedBox(width: 50),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textFieldController, // TextEditingController 할당
                autofocus: true,
                keyboardType: TextInputType.text,
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
                style: TextStyle(
                  fontSize: 16,
                  height: 1,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Color.fromRGBO(241, 241, 241, 1.0),
                  hintText: '검색어를 입력해주세요',
                  hintStyle: TextStyle(
                    color: Constants.lightGrey,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 30),
        ],
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final AllProduct = snapshot.data as List<dynamic>;
            return ListView(
              children: [
                if (keyValue.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: relatedDataList.map((data) {
                          return ListTile(
                            leading: Icon(Icons.search),
                            title: Text(data['productName']),
                            onTap: () {
                              setState(() {
                                context.push('/detail', extra : data['productId']);
                              });
                              searchRelatedData();
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
                        child: Row(
                          children: [
                            Text(
                              '최근 검색어',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                removeSearchData();
                              },
                              child: Text('모두 지우기'),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: searchDataList.map((data) {
                          return ListTile(
                            leading: Icon(Icons.watch_later_outlined),
                            title: Text(data),
                            onTap: () {
                              setState(() {
                                keyValue = data;
                                textFieldController.text = keyValue;
                              });
                              searchRelatedData();
                            },
                          );
                        }).toList(),
                      ),
                      CustomBox(),
                      Ranking(),
                    ],
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
