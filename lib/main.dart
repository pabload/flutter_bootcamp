import 'package:flutter/material.dart';
import 'package:flutter_bootcamp/example_1/example_1_page.dart';
import 'package:flutter_bootcamp/example_2/example_2_page.dart';
import 'package:flutter_bootcamp/homework_1/homework_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent[700],
        accentColor: Colors.blue[500],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green
        )
      ),
      home: HomeWorkPage(),
    );
  }
}

