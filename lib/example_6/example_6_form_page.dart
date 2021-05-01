import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bootcamp/methods/public.dart';
import 'package:flutter_bootcamp/uris.dart';
import 'package:http/http.dart' as http;

class Example6FormPage extends StatefulWidget {
  //Example6FormPage({Key key}) : super(key: key);

  @override
  _Example6FormPageState createState() => _Example6FormPageState();
}

class _Example6FormPageState extends State<Example6FormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = "";
  String _calories = "";
  AppBar _appbar() {
    return AppBar(
      title: Text('Example 6 food form'),
    );
  }

  Widget _inputName() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.name,
        onSaved: (val) => _name = val ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        validator: (val) =>
            (val != null && val.length > 5) ? null : 'Issue in Name',
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            prefixIcon: Icon(Icons.person),
            labelText: 'Name',
            hintText: 'Add a name'),
      ),
    );
  }

  Widget _inputCalories() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        onSaved: (val) => _calories = val ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        validator: (val) =>
            (val != null && val.isNotEmpty && double.tryParse(val) != null)
                ? null
                : 'Issue in calories',
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            prefixIcon: Icon(Icons.person),
            labelText: 'calories',
            hintText: 'Add a calories'),
      ),
    );
  }

  Widget _formPage() {
    return Form(
      key: _formKey,
      child: Column(
        children: [_inputName(), _inputCalories()],
      ),
    );
  }

  Widget _fabSaveData() {
    return FloatingActionButton.extended(
      onPressed: _saveData,
      label: Text('Save task'),
      icon: Icon(Icons.plus_one_outlined),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _formPage(),
      floatingActionButton: _fabSaveData(),
    );
  }

  void _saveData() async {
    final FormState? _formState = _formKey.currentState;
    if (_formState != null && _formState.validate()) {
      _formState.save();
      try {
        Map<String, dynamic> _jsonFood = {
          "name": _name,
          "calories": double.tryParse(_calories)
        };
        http.Response _response = await http.post(Uri.parse(Uris().foodApi),
            body: json.encode(_jsonFood),
            headers: {"Content-Type": "application/json"},
            encoding: Encoding.getByName("utf-8"));
        if (_response.statusCode == 201) {
          snackMessage(message: 'data saved', context: context);
          Navigator.of(context).pop();
        } else {
          final erroServer =
              await json.decode(utf8.decode(_response.bodyBytes));
          snackMessage(
              message: "${erroServer.toString()}",
              context: context,
              isError: true);
        }
      } catch (error) {
        snackMessage(
            message: '${error.toString()}', context: context, isError: true);
      }
    } else {
      snackMessage(
          message: 'Issue inside the form', context: context, isError: true);
    }
  }
}
