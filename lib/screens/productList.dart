import 'package:ecommerce/Screens/productDetail.dart';
import 'package:ecommerce/components/bottomNavigation.dart';
import 'package:ecommerce/dataService/SQLHelperProduct.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  String title;
  ProductList(this.title);

  @override
  _ProductListState createState() => _ProductListState(title);
}

class _ProductListState extends State<ProductList> {
  String title;
  _ProductListState(this.title);

  List<Map<String, dynamic>> _products = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshProducts() async {
    final data = await SQLHelperProduct.getItems();
    setState(() {
      _products = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshProducts(); // Loading the diary when the app starts
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.chevron_left,
                      size: 40.0, color: Colors.black)),
              title: Text(
                "Product List",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.blueGrey,
              centerTitle: true,
            ),
            body: _buildProductListPage(title),
          ),
          bottomNavigationBar(page: "search", context: context),
        ],
      )),
    );
  }

  _buildProductListPage(String title) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      child: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildFilterWidgets(screenSize);
          } else if (index == _products.length) {
            return const SizedBox(height: 12.0);
          } else if (title == "Hepsi") {
            return _buildProductListRow(_products, index);
          } else if (title == _products[index]['category']) {
            return _buildProductListRow(_products, index);
          } else {
            return const SizedBox(height: 0.0);
          }
        },
      ),
    );
  }

  _buildFilterWidgets(Size screenSize) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: screenSize.width,
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFilterButton("Sırala"),
              Container(
                color: Colors.black,
                width: 2.0,
                height: 24.0,
              ),
              _buildFilterButton("Filtrele"),
            ],
          ),
        ),
      ),
    );
  }

  _buildFilterButton(String title) {
    return InkWell(
      onTap: () {
        print(title);
      },
      child: Row(
        children: [
          Icon(Icons.arrow_drop_down, color: Colors.black),
          SizedBox(width: 2.0),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildProductListRow(_products, index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetail(index, _products);
        }));
      },
      child: Card(
        child: Column(
          children: [
            SizedBox(
              child: Image.asset(_products[index]['imageUrl1']),
              //height: 250.0,
              width: MediaQuery.of(context).size.width / 2.2,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(_products[index]['name'],
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _products[index]['currentPrice'].toString() + "TL",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(width: 8.0),
                      Text(_products[index]['originalPrice'].toString() + "TL",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          )),
                      const SizedBox(width: 8.0),
                      Text("%" + _products[index]['discount'].toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.cyanAccent,
                          )),
                      const SizedBox(width: 8.0),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}






// class ProductList extends StatelessWidget {
//   List<Map> aksesuarlar = [
//     {
//       "isim": "Lenovo Gaming İdea 3",
//       "fotograf": "assets/images/lenovo.jpg",
//       "fiyat": "17999"
//     },
//     {
//       "isim": "Casper Excalibur G770",
//       "fotograf": "assets/images/excaliburg770.jpg",
//       "fiyat": "15999"
//     },
//     {
//       "isim": "Casper Excalibur G780",
//       "fotograf": "assets/images/excaliburg780.jpg",
//       "fiyat": "17999"
//     },
//     {
//       "isim": "Casper Excalibur G900",
//       "fotograf": "assets/images/excaliburg900.jpg",
//       "fiyat": "15999"
//     },
//     {
//       "isim": "Lenovo Gaming İdea 3",
//       "fotograf": "assets/images/lenovo.jpg",
//       "fiyat": "17999"
//     },
//   ];
//   List<Map> cepTel = [
//     {
//       "isim": "Lenovo Gaming İdea 3",
//       "fotograf": "assets/images/lenovo.jpg",
//       "fiyat": "17999"
//     },
//     {
//       "isim": "Casper Excalibur G770",
//       "fotograf": "assets/images/excaliburg770.jpg",
//       "fiyat": "15999"
//     },
//     {
//       "isim": "Casper Excalibur G780",
//       "fotograf": "assets/images/excaliburg780.jpg",
//       "fiyat": "17999"
//     },
//     {
//       "isim": "Casper Excalibur G900",
//       "fotograf": "assets/images/excaliburg900.jpg",
//       "fiyat": "15999"
//     },
//     {
//       "isim": "Lenovo Gaming İdea 3",
//       "fotograf": "assets/images/lenovo.jpg",
//       "fiyat": "17999"
//     },
//   ];
//   List<Map> evEsyalari = [
//     {
//       "isim": "Lenovo Gaming İdea 3",
//       "fotograf": "assets/images/lenovo.jpg",
//       "fiyat": "17999"
//     },
//     {
//       "isim": "Casper Excalibur G770",
//       "fotograf": "assets/images/excaliburg770.jpg",
//       "fiyat": "15999"
//     },
//     {
//       "isim": "Casper Excalibur G780",
//       "fotograf": "assets/images/excaliburg780.jpg",
//       "fiyat": "17999"
//     },
//     {
//       "isim": "Casper Excalibur G900",
//       "fotograf": "assets/images/excaliburg900.jpg",
//       "fiyat": "15999"
//     },
//     {
//       "isim": "Lenovo Gaming İdea 3",
//       "fotograf": "assets/images/lenovo.jpg",
//       "fiyat": "17999"
//     },
//   ];
//   List<Map> giyim = [
//     {
//       "isim": "Lenovo Gaming İdea 3",
//       "fotograf": "assets/images/lenovo.jpg",
//       "fiyat": "17999"
//     },
//     {
//       "isim": "Casper Excalibur G770",
//       "fotograf": "assets/images/excaliburg770.jpg",
//       "fiyat": "15999"
//     },
//     {
//       "isim": "Casper Excalibur G780",
//       "fotograf": "assets/images/excaliburg780.jpg",
//       "fiyat": "17999"
//     },
//     {
//       "isim": "Casper Excalibur G900",
//       "fotograf": "assets/images/excaliburg900.jpg",
//       "fiyat": "15999"
//     },
//     {
//       "isim": "Lenovo Gaming İdea 3",
//       "fotograf": "assets/images/lenovo.jpg",
//       "fiyat": "17999"
//     },
//   ];
//   List<Map> temelGida = [
//     {
//       "isim": "Lenovo Gaming İdea 3",
//       "fotograf": "assets/images/lenovo.jpg",
//       "fiyat": "17999"
//     },
//     {
//       "isim": "Casper Excalibur G770",
//       "fotograf": "assets/images/excaliburg770.jpg",
//       "fiyat": "15999"
//     },
//     {
//       "isim": "Casper Excalibur G780",
//       "fotograf": "assets/images/excaliburg780.jpg",
//       "fiyat": "17999"
//     },
//     {
//       "isim": "Casper Excalibur G900",
//       "fotograf": "assets/images/excaliburg900.jpg",
//       "fiyat": "15999"
//     },
//     {
//       "isim": "Lenovo Gaming İdea 3",
//       "fotograf": "assets/images/lenovo.jpg",
//       "fiyat": "17999"
//     },
//   ];
//   late BuildContext context;
//   @override
  
//   Widget build(BuildContext context) {
//     this.context = context;
//     return Scaffold(
//       body: SafeArea(
//           child: Stack(
//         children: [
//           Scaffold(
//             appBar: AppBar(
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: Icon(Icons.chevron_left,
//                       size: 40.0, color: Colors.black)),
//               title: Text(
//                 "Product List",
//                 style: TextStyle(color: Colors.black),
//               ),
//               backgroundColor: Colors.white,
//               centerTitle: true,
//             ),
//             body: _buildProductListPage(),
//           ),
//           bottomNavigationBar("search", context),
//         ],
//       )),
//     );
//   }

//   _buildProductListPage() {
//     Size screenSize = MediaQuery.of(context).size;
//     return Container(
//       child: ListView.builder(
//           itemCount: 5,
//           itemBuilder: (context, index) {
//             if (index == 0) {
//               return _buildFilterWidgets(screenSize);
//             } else if (index == 4) {
//               return const SizedBox(height: 12.0);
//             } else {
//               return _buildProductListRow();
//               // return ListView(
//               //   children: bilgisayarlar
//               //       .map<Widget>((product) => _buildProductListRow(product))
//               //       .toList(),
//               // );
//               // return StreamBuilder<QuerySnapshot>(
//               //   stream:
//               //       FirebaseFirestore.instance.collection("products").snapshots(),
//               //   builder: (context, snapshot) {
//               //     if (!snapshot.hasData) {
//               //       return const LinearProgressIndicator();
//               //     } else {
//               //       // return _buildProductListRow(snapshot.data!.docs);
//               //       return _buildProductListRow(bilgisayarlar);
//               //     }
//               //   },
//               // );
//             }
//           }),
//     );
//   }

//   _buildFilterWidgets(Size screenSize) {
//     return Container(
//       margin: EdgeInsets.all(12.0),
//       width: screenSize.width,
//       child: Card(
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildFilterButton("Sırala"),
//               Container(
//                 color: Colors.black,
//                 width: 2.0,
//                 height: 24.0,
//               ),
//               _buildFilterButton("Filtrele"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _buildFilterButton(String title) {
//     return InkWell(
//       onTap: () {
//         print(title);
//       },
//       child: Row(
//         children: [
//           Icon(Icons.arrow_drop_down, color: Colors.black),
//           SizedBox(width: 2.0),
//           Text(title),
//         ],
//       ),
//     );
//   }

//   _buildProductListRow() {
//     return ProductListRow(
//       name: "Kazak",
//       currentPrice: 100,
//       originalPrice: 200,
//       discount: 50,
//       imageUrl:
//           "data:image/jpeg;base64,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",
//     );
//     // return snapshot.map<Widget>((data) => ProductListRow(data: data)).toList();
//     // return ProductListRow(list: list);
//     // return ProductListRow(product: product);
//   }
// }

// class _ProductListState extends State {
//   List<Map> bilgisayarlar = [
//     {
//       "name": "Lenovo Gaming İdea 3",
//       "currentPrice": 8999,
//       "originalPrice": 17999,
//       "discount": 50,
//       "imageUrl": "assets/images/lenovo.jpg ",
//     },
//     {
//       "name": "Casper Excalibur G770",
//       "currentPrice": 8999,
//       "originalPrice": 17999,
//       "discount": 50,
//       "imageUrl": "assets/images/excaliburg770.jpg",
//     },
//     {
//       "name": "Casper Excalibur G780",
//       "currentPrice": 8999,
//       "originalPrice": 17999,
//       "discount": 50,
//       "imageUrl": "assets/images/excaliburg780.jpg",
//     },
//     {
//       "name": "Casper Excalibur G900",
//       "currentPrice": 8999,
//       "originalPrice": 17999,
//       "discount": 50,
//       "imageUrl": "assets/images/excaliburg900.jpg",
//     },
//     {
//       "name": "Lenovo Gaming İdea 3",
//       "currentPrice": 8999,
//       "originalPrice": 17999,
//       "discount": 50,
//       "imageUrl": "assets/images/lenovo.jpg",
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Stack(
//         children: [
//           Scaffold(
//             appBar: AppBar(
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: Icon(Icons.chevron_left,
//                       size: 40.0, color: Colors.black)),
//               title: Text(
//                 "Product List",
//                 style: TextStyle(color: Colors.black),
//               ),
//               backgroundColor: Colors.white,
//               centerTitle: true,
//             ),
//             body: _buildProductListPage(),
//           ),
//           bottomNavigationBar("search", context),
//         ],
//       )),
//     );
//   }

//   _buildProductListPage() {
//     Size screenSize = MediaQuery.of(context).size;
//     return Container(
//       child: ListView.builder(
//           itemCount: 5,
//           itemBuilder: (context, index) {
//             if (index == 0) {
//               return _buildFilterWidgets(screenSize);
//             } else if (index == 4) {
//               return const SizedBox(height: 12.0);
//             } else {
//               return _buildProductListRow();
//               // return ListView(
//               //   children: bilgisayarlar
//               //       .map<Widget>((product) => _buildProductListRow(product))
//               //       .toList(),
//               // );
//               // return StreamBuilder<QuerySnapshot>(
//               //   stream:
//               //       FirebaseFirestore.instance.collection("products").snapshots(),
//               //   builder: (context, snapshot) {
//               //     if (!snapshot.hasData) {
//               //       return const LinearProgressIndicator();
//               //     } else {
//               //       // return _buildProductListRow(snapshot.data!.docs);
//               //       return _buildProductListRow(bilgisayarlar);
//               //     }
//               //   },
//               // );
//             }
//           }),
//     );
//   }

//   _buildFilterWidgets(Size screenSize) {
//     return Container(
//       margin: EdgeInsets.all(12.0),
//       width: screenSize.width,
//       child: Card(
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildFilterButton("Sırala"),
//               Container(
//                 color: Colors.black,
//                 width: 2.0,
//                 height: 24.0,
//               ),
//               _buildFilterButton("Filtrele"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _buildFilterButton(String title) {
//     return InkWell(
//       onTap: () {
//         print(title);
//       },
//       child: Row(
//         children: [
//           Icon(Icons.arrow_drop_down, color: Colors.black),
//           SizedBox(width: 2.0),
//           Text(title),
//         ],
//       ),
//     );
//   }

//   _buildProductListRow() {
//     return ProductListRow(
//       name: "kazak",
//       currentPrice: 100,
//       originalPrice: 200,
//       discount: 50,
//       imageUrl:
//           "data:image/jpeg;base64,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",
//     );
//     // return snapshot.map<Widget>((data) => ProductListRow(data: data)).toList();
//     // return ProductListRow(list: list);
//     // return ProductListRow(product: product);
//   }
// }
