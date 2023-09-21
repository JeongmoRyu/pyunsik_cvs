import 'package:flutter/material.dart';

class Network {
  static Map<String, String> getHeader(String token) {
    return {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': '$token',
    };
  }

  static String apiUrl = "http://j9a505.p.ssafy.io:8881/api/";
}
