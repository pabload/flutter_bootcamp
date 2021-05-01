import 'package:flutter/material.dart';
import 'package:flutter_bootcamp/methods/public.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Example4Page extends StatefulWidget {
  //Example4Page({Key key}) : super(key: key);

  @override
  _Example4PageState createState() => _Example4PageState();
}

class _Example4PageState extends State<Example4Page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  String? _nameSaved;

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

  AppBar _appbar() {
    return AppBar(
      title: Text('Example 4'),
    );
  }

  Widget _formName() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _inputName(),
        ],
      ),
    );
  }

  Widget _fabSaveForm() {
    return FloatingActionButton.extended(
      onPressed: _saveDataForm,
      label: Text('Save name'),
      icon: Icon(Icons.minimize_outlined),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Text("${(_nameSaved == null) ? "No data" : _nameSaved}"),
        _formName()
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
      floatingActionButton: _fabSaveForm(),
    );
  }

  void _readData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    _nameSaved = preferences.getString('Name');
    setState(() {});
  }

  Future<void> _writeData({required final String value}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('Name', value);
    //setState(() {});
  }

  _saveDataForm() async {
    final FormState? _formState = _formKey.currentState;
    if (_formState != null && _formState.validate()) {
      _formState.save();
      try {
        await _writeData(value: _name);
        snackMessage(message: 'data saved', context: context);
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
