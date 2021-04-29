import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Example2Page extends StatefulWidget {
  //Example2Page({Key key}) : super(key: key);

  @override
  _Example2PageState createState() => _Example2PageState();
}

class _Example2PageState extends State<Example2Page> {
  int _number = 0;
  AppBar _appbar() {
    return AppBar(
      title: Text('Example 2'),
    );
  }

  Widget _body() {
    return Container(
      child: Center(
        child: Text(
          'number $_number',
          style: TextStyle(fontSize: 30, color: Colors.redAccent),
        ),
      ),
    );
  }

  Widget _fabIncrement() {
    return FloatingActionButton.extended(
      onPressed: _incrementNumber,
      label: Text('Increment'),
      icon: Icon(Icons.add),
    );
  }

  Widget _fabDecrement() {
    return FloatingActionButton.extended(
      onPressed: _decrementNumber,
      label: Text('Decrement'),
      icon: Icon(Icons.minimize_outlined),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _fabIncrement(),
          SizedBox(
            height: 15,
          ),
          _fabDecrement()
        ],
      ),
    );
  }

  void _incrementNumber() {
    _number++;
    this.setState(() {});
  }

  void _decrementNumber() {
    _number--;
    this.setState(() {});
  }
}
