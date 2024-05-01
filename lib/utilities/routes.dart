import 'package:ecommerce/Screens/productDetail.dart';
import 'package:ecommerce/dataService/adminProductService.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/screens/admin.dart';
import 'package:ecommerce/screens/productList.dart';
import 'package:ecommerce/screens/register.dart';
import 'package:ecommerce/utilities/constants.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  bool? logcon;
  static final routes = <String, WidgetBuilder>{
    Constants.ROUTE_PRODUCT_DETAIL: (BuildContext context) =>
        ProductDetail(1, []),
    Constants.ROUTE_PRODUCT_LIST: (BuildContext context) => ProductList(""),
    Constants.ROUTE_HOME_PAGE: (BuildContext context) => HomePage(true),
    Constants.ROUTE_LOGIN_PAGE: (BuildContext context) => LoginPage(),
    Constants.ROUTE_REGISTER_PAGE: (BuildContext context) => RegisterPage(),
    Constants.ROUTE_ADMIN_PAGE: (BuildContext context) => const AdminHomePage(),
  };
}
