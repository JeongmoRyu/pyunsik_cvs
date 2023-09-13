import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';

class Cart extends ChangeNotifier {
  //final List<Product> _products = [];
  final List<Product> _products = [
    new Product(1, 'test product short', '', 1800),
    new Product(2, 'test product middle middle', '', 39900),
    new Product(3, 'test product long long long long long long long', '', 1498000),
  ];
  final List<bool> _isChecked = [true, true, true];

  bool _isCheckedAll = true;


  List<Product> get products => _products;
  List<bool> get isChecked => _isChecked;
  bool get isCheckedAll => _isCheckedAll;

  int get numberOfProducts => _products.length;
  bool get isEmpty => _products.isEmpty;

  int getTotalPrice() {
    int totalPrice = 0;
    for (int i = 0; i < _products.length; i++) {
      if (_isChecked[i]) {
        totalPrice += _products[i].price;
      }
    }
    return totalPrice;
  }

  void add(Product product) {
    _products.add(product);
    _isChecked.add(true);
    notifyListeners();
  }

  void remove(Product product) {
    _isChecked.removeAt(_products.indexOf(product));
    _products.remove(product);
    notifyListeners();
  }

  void removeSelected() {
    for (int i = 0; i < _products.length; i++) {
      if (_isChecked[i]) {
        _products.removeAt(i);
        _isChecked.removeAt(i);
      }
    }
    notifyListeners();
  }

  void toggleCheckbox(int index, bool value) {
    _isChecked[index] = value;
    if (!value) { // 개별 체크가 취소 되면 모두 체크 해제
      _isCheckedAll = value;
    }
    for (int i = 0; i < _isChecked.length; i++) { //모든 개별 체크가 되있으면 모두체크 확인
      if (!_isChecked[i]) {
        notifyListeners();
        return;
      }
    }
    _isCheckedAll = value;
    notifyListeners();
  }
  void toggleAllCheckbox(bool value) {
    _isCheckedAll = value;
    for (int i = 0; i < _isChecked.length; i++) {
      _isChecked[i] = value;
    }
    notifyListeners();
  }

}