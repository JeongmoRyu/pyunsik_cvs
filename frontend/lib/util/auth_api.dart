import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class AuthApi {
  static const String url = "http://j9a505.p.ssafy.io:8882/api";
  static Map<String, String> header = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };

  static Future<dynamic> createUser(String id, String password) async {
    final response = await http.post(
      Uri.parse('$url/auth'),
      headers: header,
      body: jsonEncode(<String, String>{
        'nickname': id,
        'password':password,
        'fcmToken':'testToken',
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return response;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create user');
    }
  }

  static Future<UserModel> login(String id, String password) async {
    final response = await http.post(
      Uri.parse('$url/auth/login'),
      headers: header,
      body: jsonEncode(<String, String>{
        'nickname': id,
        'password':password,
      }),
    );

    if (response.statusCode == 200) {
      // then parse the JSON.
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to login: ${jsonDecode(response.body)}');
    }
  }
}