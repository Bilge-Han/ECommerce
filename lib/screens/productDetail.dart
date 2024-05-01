import 'package:ecommerce/dataService/SQLHelperBasket.dart';
import 'package:ecommerce/dataService/SQLHelperFavorite.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  int id;
  List<Map<String, dynamic>> products = [];
  ProductDetail(this.id, this.products, {Key? key}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState(id, products);
}

class _ProductDetailState extends State with TickerProviderStateMixin {
  int id;
  List<Map<String, dynamic>> products = [];
  _ProductDetailState(this.id, this.products);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.chevron_left,
                        size: 40.0, color: Colors.black)),
                backgroundColor: Colors.blueGrey,
                title: const Text("Product Detail",
                    style: TextStyle(color: Colors.black)),
              ),
              body: _buildProductDetails(context),
              bottomNavigationBar: _buildBottomNavigationBar(id, products),
            ),
          ],
        ),
      ),
    );
  }

  _buildProductDetails(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImages(context),
              _buildProductTitle(),
              const SizedBox(height: 12.0),
              _buildProductPrice(),
              const SizedBox(height: 12.0),
              _buildDivider(size),
              const SizedBox(height: 12.0),
              _buildFurtherInfo(),
              const SizedBox(height: 12.0),
              _buildDivider(size),
              const SizedBox(height: 12.0),
              _buildInfo(),
            ],
          ),
        ),
      ],
    );
  }

  _buildProductImages(BuildContext context) {
    TabController imagesController = TabController(length: 2, vsync: this);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 250.0,
        child: Center(
          child: DefaultTabController(
              length: 2,
              child: Stack(
                children: [
                  TabBarView(
                    controller: imagesController,
                    children: [
                      Image.asset(products[id]['imageUrl1']),
                      Image.asset(products[id]['imageUrl2']),
                    ],
                  ),
                  Container(
                    alignment: const FractionalOffset(0.5, 0.95),
                    child: TabPageSelector(
                      controller: imagesController,
                      selectedColor: Colors.grey,
                      color: Colors.white,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  _buildProductTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: Text(
          products[id]['name'],
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
    );
  }

  _buildProductPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Text(
            products[id]['currentPrice'].toString() + "TL",
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(width: 8.0),
          Text(
            products[id]['originalPrice'].toString() + "TL",
            style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough),
          ),
          SizedBox(width: 8.0),
          Text(
            "%" + products[id]['discount'].toString(),
            style: const TextStyle(fontSize: 12, color: Colors.pinkAccent),
          ),
        ],
      ),
    );
  }

  _buildDivider(Size screenSize) {
    return Column(
      children: [
        Container(
          color: Colors.grey,
          width: screenSize.width,
          height: 0.25,
        ),
      ],
    );
  }

  _buildFurtherInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: const [
          Icon(
            Icons.local_offer,
            color: Colors.black87,
          ),
          SizedBox(width: 12.0),
          Text("Daha fazla bilgi için tıklayınız",
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  _buildSizeArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.straighten,
                color: Colors.green,
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                "Beden :S-M-L ",
                style: TextStyle(color: Colors.green),
              )
            ],
          ),
          Row(
            children: [
              Text(
                "Beden Tablosu",
                style: TextStyle(color: Colors.blue, fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildInfo() {
    TabController tabController = TabController(length: 2, vsync: this);
    return Column(
      children: [
        TabBar(
          controller: tabController,
          tabs: [
            Tab(
              child: Text(
                products[id]['name'],
                style: TextStyle(color: Colors.black),
              ),
            ),
            const Tab(
              child: Text(
                "Ürün Yorumları",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          height: 40.0,
          child: TabBarView(
            controller: tabController,
            children: const [
              Text(
                "%60 Pamuk, %30 Polyester",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "5 Yıldız verdim mükemmel",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _addItemBasket(id, products) async {
    await SQLHelperBasket.createItem(
      products[id]['name'],
      products[id]['currentPrice'],
      products[id]['originalPrice'],
      products[id]['discount'],
      products[id]['imageUrl1'],
      products[id]['imageUrl2'],
      products[id]['category'],
    );
    // _refreshProducts();
  }

  Future<void> _addItemFavorite(id, products) async {
    await SQLHelperFavorite.createItem(
      products[id]['name'],
      products[id]['currentPrice'],
      products[id]['originalPrice'],
      products[id]['discount'],
      products[id]['imageUrl1'],
      products[id]['imageUrl2'],
      products[id]['category'],
    );
    // _refreshProducts();
  }

  _buildBottomNavigationBar(id, products) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: RaisedButton(
              onPressed: () {
                _addItemFavorite(id, products);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Successfully added a product from favorites!'),
                  backgroundColor: Colors.redAccent,
                ));
              },
              color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    "İsteklere Ekle",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: RaisedButton(
              onPressed: () {
                _addItemBasket(id, products);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Successfully added a product from basket!'),
                  backgroundColor: Colors.greenAccent,
                ));
              },
              color: Colors.greenAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.shopping_basket,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    "Sepete Ekle",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
