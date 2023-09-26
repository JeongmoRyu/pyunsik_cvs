import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';

class User extends ChangeNotifier {
  late String _uuid;
  late String _nickname;
  late String _fcmToken;
  late String _accessToken;

  String get uuid => _uuid;

  String get nickname => _nickname;

  String get fcmToken => _fcmToken;

  String get accessToken => _accessToken;

  void setFromUserModel(UserModel model) {
    _nickname = model.nickname;
    _uuid = model.uuid;
    _accessToken = model.accessToken;
    _fcmToken = model.fcmToken;
    print('로그인 성공: $_nickname, $_accessToken');
    notifyListeners();
  }
}