import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bootcamp/example_6/example_6_form_page.dart';
import 'package:flutter_bootcamp/methods/public.dart';
import 'package:flutter_bootcamp/uris.dart';
import 'package:http/http.dart' as http;

class Example6Page extends StatefulWidget {
  //Example6Page({Key key}) : super(key: key);

  @override
  _Example6PageState createState() => _Example6PageState();
}

class _Example6PageState extends State<Example6Page> {
  List<dynamic>? _list;
  AppBar _appbar() {
    return AppBar(
      title: Text('Example 6'),
    );
  }
   Widget _fabGoToForm() {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Example6FormPage())).whenComplete(() => _loadDataFromServer()),
      label: Text('Add task'),
      icon: Icon(Icons.add),
    );
  }
  Widget _body() {
    if (_list == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_list!.isEmpty) {
      return Center(
        child: Text('No data'),
      );
    }
    return ListView(
      children: _list!.map((food) => Text('Food: ${food.toString()}')).toList(),
    );
  }
  @override
  void initState() { 
    super.initState();
    _loadDataFromServer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
      floatingActionButton: _fabGoToForm(),
    );
  }

  void _loadDataFromServer() async {
    try {
      http.Response _response = await http.get(
        Uri.parse(Uris().foodApi),
        headers: {
        "Content-Type": "application/json"
      }).timeout(Duration(seconds: 20));
      if (_response.statusCode == 200) {
        _list = await json.decode(utf8.decode(_response.bodyBytes));
      }
      print(_list);
      setState(() {});
    } catch (error) {
      snackMessage(message: "${error.toString()}", context: context,isError: true);
    }
  }
}
