import 'package:ecommerce/components/bottomNavigation.dart';
import 'package:ecommerce/components/header.dart';
import 'package:ecommerce/screens/productList.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  final List<String> categories = [
    "Hepsi",
    "Bilgisayarlar",
    "Aksesuarlar",
    "Cep Telefonlari",
    "Akilli Esyalar",
    "Giyim",
    "Mutfak"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.chevron_left,
                size: 40.0, color: Colors.black)),
        backgroundColor: Colors.blueGrey,
        title: const Text("Kategoriler", style: TextStyle(color: Colors.black)),
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
                    //Kategoriler
                    Expanded(
                      child: ListView(
                          children: categories
                              .map((String title) =>
                                  buildCategory(title, context))
                              .toList()),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ]),
            ),
            //Bottom navigation
            bottomNavigationBar(page: "search", context: context),
          ],
        ),
      ),
    );
  }
}

Widget buildCategory(String title, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ProductList(title);
      }));
    },
    child: Container(
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.brown[300],
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ]),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0A1034)),
      ),
    ),
  );
}
