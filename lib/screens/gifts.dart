import 'package:flutter/material.dart';
import '../components/bottomNavigation.dart';
import '../components/header.dart';

class GiftsPage extends StatefulWidget {
  const GiftsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GiftsPageState();
}

class _GiftsPageState extends State<GiftsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.chevron_left, size: 40.0, color: Colors.black)),
        backgroundColor: Colors.blueGrey,
        title: Text("Kuponlarım", style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Expanded(
                      child: ListView(
                    children: [
                      Text("Şu anda aktif kuponunuz ürününüz bulunmamaktadır ")
                      //buildCategory("Giriş Yap", context),
                    ],
                  ))
                ],
              ),
            ),
            bottomNavigationBar(page: "profile", context: context),
          ],
        ),
      ),
    );
  }
}
