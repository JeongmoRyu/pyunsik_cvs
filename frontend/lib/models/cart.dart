import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';

class Cart extends ChangeNotifier {
  final List<Product> _products = [];
  // final List<Product> _products = [
  //   new Product(1, 'test product short', '', 1800),
  //   new Product(2, 'test product middle middle', '', 39900),
  //   new Product(3, 'test product long long long long long long long', '', 1498000),
  // ];
  final List<bool> _isSelected = [];

  bool _isSelectedAll = true;


  List<Product> get products => _products;
  List<bool> get isSelected => _isSelected;
  bool get isSelectedAll => _isSelectedAll;

  int get numberOfProducts => _products.length;
  int get numberOfSelected => _isSelected.where(
          (element) => element == true
        ).length;
  bool get isEmpty => _products.isEmpty;

  int getTotalPrice() {
    int totalPrice = 0;
    for (int i = 0; i < _products.length; i++) {
      if (_isSelected[i]) {
        totalPrice += _products[i].price;
      }
    }
    return totalPrice;
  }

  void add(Product product) {
    _products.add(product);
    _isSelected.add(true);
    notifyListeners();
  }

  void remove(Product product) {
    _isSelected.removeAt(_products.indexOf(product));
    _products.remove(product);
    notifyListeners();
  }

  void removeSelected() {
    var selectedProducts = [];
    for (int i = 0; i < _products.length; i++) {
      if (_isSelected[i]) {
        selectedProducts.add(_products[i]);
      }
    }
    for (var product in selectedProducts) {
      remove(product);
    }
    notifyListeners();
  }

  void toggleCheckbox(int index, bool value) {
    _isSelected[index] = value;
    if (!value) { // 개별 체크가 취소 되면 모두 체크 해제
      _isSelectedAll = value;
    }
    for (int i = 0; i < _isSelected.length; i++) { //모든 개별 체크가 되있으면 모두체크 확인
      if (!_isSelected[i]) {
        notifyListeners();
        return;
      }
    }
    _isSelectedAll = value;
    notifyListeners();
  }
  void toggleAllCheckbox(bool value) {
    _isSelectedAll = value;
    for (int i = 0; i < _isSelected.length; i++) {
      _isSelected[i] = value;
    }
    notifyListeners();
  }

}