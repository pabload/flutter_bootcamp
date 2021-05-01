import 'package:flutter/material.dart';
import 'package:flutter_bootcamp/database_helper.dart';
import 'package:flutter_bootcamp/example_5/example_5_form_page.dart';
import 'package:flutter_bootcamp/models_objetcs/task.dart';
import 'package:sqflite/sqflite.dart';

class Example5Page extends StatefulWidget {
  //Example5Page({Key key}) : super(key: key);

  @override
  _Example5PageState createState() => _Example5PageState();
}

class _Example5PageState extends State<Example5Page> {
  List<Task>? listTaks;

  AppBar _appbar() {
    return AppBar(
      title: Text('Example 5'),
    );
  }

  Widget _fabGoToForm() {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Example5FormPage())).whenComplete(() => _readDataFromDB()),
      label: Text('Add task'),
      icon: Icon(Icons.add),
    );
  }

  Widget _body() {
    if (listTaks == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (listTaks!.isEmpty) {
      return Center(
        child: Text('No data'),
      );
    }
    return ListView(
      children: listTaks!.map((task) => Text('Task: ${task.name}, Duration: ${task.seconds}')).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    _readDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
      floatingActionButton: _fabGoToForm(),
    );
  }

  void _readDataFromDB() async {
    final Database? db = await DatabaseHelper.db.database;
    List<dynamic>? results = await db!.query("task");
    if (results == null || results.isEmpty) {
      return setState(() {
        listTaks = [];
      });
    }
    setState(() {
      listTaks = results.map((task) => Task.fromMapSQL(task)).toList();
    });
  }
}
