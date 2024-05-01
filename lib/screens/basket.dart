import 'package:flutter/material.dart';
import '../components/bottomNavigation.dart';
import '../components/header.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
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
                  header("Sepetim", context),
                  SizedBox(height: 16),
                  Expanded(
                      child: ListView(
                    children: [
                      Text("Şu anda sepetinizde ürün bulunmamaktadır")
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
