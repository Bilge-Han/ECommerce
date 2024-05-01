import 'package:ecommerce/dataService/SQLHelperPerson.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<Map<String, dynamic>> _persons = [];
  bool _isLoading = true;
  void _refreshPersons() async {
    final data = await SQLHelperPerson.getItems();
    setState(() {
      _persons = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshPersons(); // Loading the diary when the app starts
  }

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _yetkiController = TextEditingController();
  Future<void> _addItem() async {
    await SQLHelperPerson.createItem(_userNameController.text,
        _passwordController.text, _yetkiController.text);
    _refreshPersons();
  }

  Widget build(BuildContext context) {
    final NameField = TextField(
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Ad",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final surNameField = TextField(
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Soy Ad",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final userNameField = TextField(
      controller: _userNameController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Kullanıcı adı",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Parola",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final password2Field = TextField(
      controller: _yetkiController,
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Yetki",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.brown[300],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          await _addItem();
          _userNameController.text = '';
          _passwordController.text = '';
          Navigator.of(context).pop();
        },
        child: Text(
          "Kayıt Ol",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
        ),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  NameField,
                  const SizedBox(height: 15),
                  surNameField,
                  const SizedBox(height: 15),
                  userNameField,
                  const SizedBox(height: 15),
                  passwordField,
                  const SizedBox(height: 15),
                  password2Field,
                  const SizedBox(height: 25),
                  registerButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
