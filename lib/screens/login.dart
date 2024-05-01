import 'package:ecommerce/dataService/SQLHelperPerson.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

Future<void> loginControl(
    String userName, String password, _persons, context) async {
  bool logcon = false;
  for (var i = 0; i < _persons.length; i++) {
    if (_persons[i]['userName'] == userName &&
        _persons[i]['password'] == password) {
      logcon = true;
      if (_persons[i]['yetki'] == "Admin") {
        Navigator.of(context).pushNamed(Constants.ROUTE_ADMIN_PAGE);
      } else if (_persons[i]['yetki'] == "Müşteri") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage(logcon);
        }));
      }
    }
  }
  if (logcon == false) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('username or password is wrong'),
    ));
  }
}

class _LoginPageState extends State<LoginPage> {
  List<Map<String, dynamic>> _persons = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshProducts() async {
    final data = await SQLHelperPerson.getItems();
    setState(() {
      _persons = data;
      _isLoading = false;
    });
  }

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _refreshProducts(); // Loading the diary when the app starts
  }

  Widget build(BuildContext context) {
    final emailField = TextField(
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

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.brown[300],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          loginControl(_userNameController.text, _passwordController.text,
              _persons, context);
        },
        child: Text(
          "Giriş yap",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
        ),
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.brown[300],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.of(context).pushNamed(Constants.ROUTE_REGISTER_PAGE);
        },
        child: Text(
          "Kayıt ol",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
        ),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Image.asset("assets/images/diamond.png"),
                    SizedBox(height: 10.0),
                    emailField,
                    SizedBox(height: 10.0),
                    passwordField,
                    SizedBox(height: 15.0),
                    loginButton,
                    SizedBox(height: 10.0),
                    registerButton
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
