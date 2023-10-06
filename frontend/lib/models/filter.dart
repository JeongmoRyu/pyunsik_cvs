import 'package:flutter/material.dart';
//선택된 카테고리 표시,
//선택된 옵션 삭제 버튼
// 가격 원 기본 최소 ~ 최대 금액
// 행사여부
// 편의점 별
class Filter extends ChangeNotifier {
  static const int defaultMin = 0;
  static const int defaultMax = 9999999;
  static const Map<String, String> keyMap = {
    '가격 (원)' : 'price',
    '카테고리' : 'category',
    '편의점' : 'convenienceCodes',
    '할인행사' : 'promotionCodes'
  };
  static const Map<String, String> valueMap = {
    '간편식사' : '1',
    '즉석요리' : '2',
    '과자' : '3',
    '아이스크림' : '4',
    '식품' : '5',
    '음료' : '6',
    'GS25' : '1',
    'CU' : '2',
    '7-ELEVEN' : '3',
    'emart24' : '4',
    '1+1' : '1',
    '2+1' : '2',
  };
  final Map<String, List<String>> _filterChoice = {};
  final Map<String, List<int>> _filterRange = {};


  Map<String, List<String>> get filterChoice => _filterChoice;
  Map<String, List<int>> get filterRange => _filterRange;

  Map<String, dynamic> getQueryParams() {
    Map<String, dynamic> result = {};

    _filterChoice.forEach((key, valueList) {
      result[keyMap[key]!] = [];
      for (String value in valueList) {
        result[keyMap[key]!].add(valueMap[value]);
      }
    });
    _filterRange.forEach((key, valueList) {
      result[keyMap[key]!] = [];
      for (int value in valueList) {
        result[keyMap[key]!].add('$value');
      }
    });
    print('result = ${result}');
    return result;
  }

  void addChoice(String tag, String option) {
    if (_filterChoice[tag] == null || tag == '카테고리') { //카테고리는 하나만 선택 가능
      _filterChoice[tag] = [];
    }
    
    _filterChoice[tag]?.add(option);
    notifyListeners();
  }

  void removeChoice(String tag, String option) {
    _filterChoice[tag]?.remove(option);
    notifyListeners();
  }

  bool doesExists(String tag, String option) {
    if (_filterChoice[tag] == null) {
      return false;
    }
    return _filterChoice[tag]!.contains(option);
  }

  void changeRange(String tag, int min, int max) {
    _filterRange[tag] = [min, max];
    // print('change range ${_filterRange}');
    notifyListeners();
  }

  void resetFilter() {
    _filterChoice.clear();
    _filterRange.clear();
    notifyListeners();
  }
}