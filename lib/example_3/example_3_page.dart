import 'dart:math';

import 'package:flutter/material.dart';

class Example3Page extends StatefulWidget {
  //Example3Page({Key key}) : super(key: key);

  @override
  _Example3PageState createState() => _Example3PageState();
}

class _Example3PageState extends State<Example3Page> {
  List<int> _list = [];
  AppBar _appbar() {
    return AppBar(
      title: Text('Example 3'),
    );
  }

  Widget _body() {
    if (_list.isEmpty)
      return Container(
        child: Center(
          child: Text(
            'No data',
            style: TextStyle(fontSize: 30, color: Colors.redAccent),
          ),
        ),
      );
    return ListView(
        children: _list.map((_number) => _customItem(numberItem: _number)).toList());
  }

  Widget _customItem({required final int numberItem}) {
    return ListTile(
      title: Text('$numberItem'),
      onTap: ()=>_onTapItem(removeNumber: numberItem),
    );
  }
  Widget _fabAddNumber() {
    return FloatingActionButton.extended(
      onPressed: _addSomeNumber,
      label: Text('add number'),
      icon: Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
      floatingActionButton: _fabAddNumber(),
    );
  }

  void _addSomeNumber() {
    _list.add(Random().nextInt(99999));
    setState(() {});
  }
  _onTapItem({required final int removeNumber}){
    _list.remove(removeNumber);
    setState(() {});
  }
}
