import 'package:flutter/material.dart';
import 'package:frontend/models/product_detail.dart';

class Cart extends ChangeNotifier {
  final List<ProductDetail> _products = [];
  final List<bool> _isSelected = [];

  bool _isSelectedAll = true;


  List<ProductDetail> get products => _products;
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

  int getTotalKcal() {
    int totalKcal = 0;
    for (int i = 0; i < _products.length; i++) {
      if (_isSelected[i]) {
        totalKcal += _products[i].kcal;
      }
    }
    return totalKcal;
  }
  double getTotalCarb() {
    double totalCarb = 0;
    for (int i = 0; i < _products.length; i++) {
      if (_isSelected[i]) {
        totalCarb += _products[i].carb;
      }
    }
    return totalCarb;
  }
  double getTotalProtein() {
    double totalProtein = 0;
    for (int i = 0; i < _products.length; i++) {
      if (_isSelected[i]) {
        totalProtein += _products[i].protein;
      }
    }
    return totalProtein;
  }
  double getTotalSodium() {
    double totalSodium = 0;
    for (int i = 0; i < _products.length; i++) {
      if (_isSelected[i]) {
        totalSodium += _products[i].sodium;
      }
    }
    return totalSodium;
  }
  double getTotalFat() {
    double totalFat = 0;
    for (int i = 0; i < _products.length; i++) {
      if (_isSelected[i]) {
        totalFat += _products[i].fat;
      }
    }
    return totalFat;
  }


  void add(ProductDetail productDetail) {
    _products.add(productDetail);
    _isSelected.add(true);
    notifyListeners();
  }

  void remove(ProductDetail productDetail) {
    _isSelected.removeAt(_products.indexOf(productDetail));
    _products.remove(productDetail);
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