import 'package:ecommerce/screens/home.dart';
import 'package:flutter/material.dart';
import '../components/bottomNavigation.dart';
import '../components/header.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  bool? logcon;
  ProfilePage(this.logcon);

  @override
  State<StatefulWidget> createState() => _ProfilePageState(logcon);
}

class _ProfilePageState extends State<ProfilePage> {
  final bool? _logcon;
  _ProfilePageState(this._logcon);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ana Sayfa'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Başlık
                  //header("Profilim", context),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          if (_logcon == true) {
                            return buildCategory("Çıkış Yap", context,
                                HomePage(false), Colors.red);
                          } else {
                            return buildCategory("Giriş Yap", context,
                                LoginPage(), Colors.green);
                          }
                        }),
                  ),
                ],
              ),
            ),
            bottomNavigationBar(
                page: "profile", context: context, logcon: _logcon),
          ],
        ),
      ),
    );
  }
}

Widget buildCategory(
    String title, BuildContext context, Widget widget, Color color) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return widget;
      }));
    },
    child: Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
            )
          ]),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0A1034)),
      ),
    ),
  );
}
