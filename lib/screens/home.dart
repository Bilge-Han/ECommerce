import 'package:ecommerce/dataService/adminFavoriteService.dart';
import 'package:ecommerce/screens/bestSeller.dart';
import 'package:ecommerce/screens/categories.dart';
import 'package:ecommerce/screens/favorites.dart';
import 'package:ecommerce/screens/gifts.dart';
import 'package:flutter/material.dart';

import '../components/bottomNavigation.dart';
import '../components/label.dart';

class HomePage extends StatefulWidget {
  bool? logcon;
  HomePage(this.logcon);
  @override
  State<StatefulWidget> createState() => _HomePageState(logcon);
}

class _HomePageState extends State<HomePage> {
  final bool? _logcon;
  _HomePageState(this._logcon);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Ana Sayfa'),
              backgroundColor: Colors.blueGrey,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(children: [
                //BANNER
                buildBanner(),
                //BUTTONS
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildNavigation(
                        text: "Kategoriler",
                        icon: Icons.category_sharp,
                        widget: CategoriesPage(),
                        context: context,
                      ),
                      buildNavigation(
                        text: "Favoriler",
                        icon: Icons.favorite_border_sharp,
                        widget: AdminFavoriteServicePage(),
                        context: context,
                      ),
                      buildNavigation(
                        text: "Kuponlarım",
                        icon: Icons.card_giftcard,
                        widget: GiftsPage(),
                        context: context,
                      ),
                      buildNavigation(
                        text: "Çok Satanlar",
                        icon: Icons.people,
                        widget: const BestSellersPage(),
                        context: context,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                //SALES TITLE
                const Text(
                  "İndirimler",
                  style: TextStyle(
                      color: Color(0xFF0A1034),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),

                //SALES ITEMS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSalesItem(
                      text: "İphone 11 Pro",
                      photoUrl: "assets/images/telefon.jpg",
                      discount: "%50",
                      screenWidth: screenWidth,
                    ),
                    buildSalesItem(
                      text: "Excalibur G780",
                      photoUrl: "assets/images/excaliburg780.jpg",
                      discount: "%10",
                      screenWidth: screenWidth,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSalesItem(
                      text: "Xiaomi Mi Robot Süpürge ve Paspas",
                      photoUrl: "assets/images/rbt.jpg",
                      discount: "%34",
                      screenWidth: screenWidth,
                    ),
                    buildSalesItem(
                      text: "Bebek El Çantsı",
                      photoUrl: "assets/images/canta.jpg",
                      discount: "%50",
                      screenWidth: screenWidth,
                    ),
                  ],
                ),
              ]),
            ),
          ),
          bottomNavigationBar(page: "home", context: context, logcon: _logcon),
        ],
      ),
    ));
  }
}

Widget buildBanner() {
  return Padding(
    padding: const EdgeInsets.only(top: 24.0),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 24, right: 36, top: 14, bottom: 18),
      decoration: BoxDecoration(
        color: Colors.brown[300],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "BilgeZone",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "E-Ticaret Uygulaması",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Image.asset(
            "assets/images/diamond.png",
            cacheHeight: 57,
            cacheWidth: 75,
          ),
        ],
      ),
    ),
  );
}

buildNavigation({
  required String text,
  required IconData icon,
  Widget? widget,
  BuildContext? context,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context!, MaterialPageRoute(builder: (context) {
        return widget!;
      }));
    },
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xFFE0ECF8)),
          child: Icon(
            icon,
            color: Color(0xFF0001FC),
            size: 18,
          ),
        ),
        SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            color: Color(0xFF1F53E4),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget buildSalesItem({
  required String text,
  required String photoUrl,
  required String discount,
  required double screenWidth,
}) {
  return Container(
    width: (screenWidth - 60) * 0.5,
    padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 21),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //%50
        label(discount),
        //telefon resmi
        SizedBox(
          height: 22,
        ),
        Center(
          child: Image.asset(
            photoUrl,
          ),
        ),
        SizedBox(height: 22),
        //ismi
        Center(
          child: Text(text,
              style: TextStyle(
                  fontSize: 18,
                  color: Color(
                    0xFF0A1034,
                  ))),
        ),
        SizedBox(height: 35),
      ],
    ),
  );
}
