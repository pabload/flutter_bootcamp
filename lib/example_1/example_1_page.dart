import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Example1Page extends StatefulWidget {
  //Example1Page({Key key}) : super(key: key);

  @override
  _Example1PageState createState() => _Example1PageState();
}

class _Example1PageState extends State<Example1Page> {
  AppBar _appbar() {
    return AppBar(
      title: Text('Example 1'),
    );
  }
  Widget _body(){
    return Container(
        child: Center(
          child: Text(
            'HOLA MUNDOoo',
            style: TextStyle(fontSize: 30, color: Colors.redAccent),
          ),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body()
    );
  }
}
