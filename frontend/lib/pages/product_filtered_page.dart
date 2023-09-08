import 'package:flutter/material.dart';
import 'package:frontend/molecules/vertical_list.dart';
import 'package:frontend/molecules/appbar.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(),// AppBar에 표시할 제목
        body: ScrollEffect(),
      ),
    );
  }
}
