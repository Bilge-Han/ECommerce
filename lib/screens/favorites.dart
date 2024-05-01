import 'package:flutter/material.dart';
import '../components/bottomNavigation.dart';
import '../components/header.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Başlık
                  header("Favorilerim", context),
                  SizedBox(height: 16),
                  Expanded(
                      child: ListView(
                    children: [
                      Text("Şu anda favori ürününüz bulunmamaktadır")
                      //buildCategory("Giriş Yap", context),
                    ],
                  ))
                ],
              ),
            ),
            bottomNavigationBar(page: "cart", context: context),
          ],
        ),
      ),
    );
  }
}
