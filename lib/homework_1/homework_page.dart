

import 'package:flutter/material.dart';

class HomeWorkPage extends StatefulWidget {
  @override
  _HomeWorkPageState createState() => _HomeWorkPageState();
}

class _HomeWorkPageState extends State<HomeWorkPage> {
  int _number = 0;
  AppBar _appbar() {
    return AppBar(
      title: Text('Example 2'),
    );
  }

  Widget _body() {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'number $_number',
              style: TextStyle(
                  fontSize: 30,
                  color: _number.isEven ? Colors.red : Colors.blue),
            ),
            Text(
              _number.isEven?'Is Even':'Is odd',
              style: TextStyle(
                  fontSize: 30,
                  color: _number.isEven ? Colors.red : Colors.blue),
            ),
          ],
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
