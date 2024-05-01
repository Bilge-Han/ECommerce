import 'package:ecommerce/dataService/adminBasketService.dart';
import 'package:ecommerce/screens/profile.dart';
import 'package:ecommerce/screens/search.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';

Widget bottomNavigationBar(
    {required String page, required BuildContext context, bool? logcon}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, -3),
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10),
        ],
        color: const Color(0xFFEFF5FB),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavIcon(
            iconData: Icons.home_filled,
            active: page == "home",
            widget: HomePage(logcon),
            context: context,
          ),
          buildNavIcon(
              iconData: Icons.search,
              active: page == "search",
              widget: const SearchPage(),
              context: context),
          buildNavIcon(
            iconData: Icons.shopping_basket,
            active: page == "cart",
            widget: AdminBasketServicePage(),
            context: context,
          ),
          buildNavIcon(
            iconData: Icons.person,
            active: page == "profile",
            widget: ProfilePage(logcon),
            context: context,
          ),
        ],
      ),
    ),
  );
}

Widget buildNavIcon(
    {required IconData iconData,
    required bool active,
    Widget? widget,
    BuildContext? context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context!, MaterialPageRoute(builder: (context) {
        return widget!;
      }));
    },
    child: Icon(
      iconData,
      size: 20,
      color: Color(active ? 0xFF0001FC : 0xFF0A1034),
    ),
  );
}
