import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:ecommerce/dataService/SQLHelperProduct.dart';
import 'package:ecommerce/screens/productDetail.dart';
import 'package:flutter/material.dart';
import '../components/bottomNavigation.dart';
import '../components/header.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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

  TextEditingController textController = TextEditingController();
  String aranan = ""; //Arama çubuguna girilen değer
  String arananEkran = ""; //Ekranda gösterilen Arama çubugundan alınan veri
  Color color = Colors.deepOrange; //Arkaplan rengi değiştirmek için
  @override
  void initState() {
    super.initState();
    _refreshProducts();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.chevron_left,
                      size: 40.0, color: Colors.black)),
              backgroundColor: Colors.blueGrey,
              title: Text("Search", style: TextStyle(color: Colors.black)),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  //Aşağıda arama yapıldıgında arama yapılan kelimeyi ekran da göstrecektir.
                  child: Center(
                    child: Text("$arananEkran",
                        style: Theme.of(context).textTheme.overline),
                  ),
                ),
              ],
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 50.0, right: 10, left: 10),
              child: AnimSearchBar(
                width: 400, //Arama çubuğu uzunlugu için düzenlenebilir
                helpText:
                    "Arama...", //Arama bölümüne giriş olmadığında görülecek olan yazı
                textController: textController, //Girilen kelimeler
                suffixIcon: const Icon(Icons.search), //Arama simgesi

                //Arama simgesine tıklama olayı aşağıdadır.
                onSuffixTap: () {
                  setState(() {
                    aranan = textController.text
                        .toString(); //Girilen kelimeyi aranan adlı değişkenine atıyoruz.
                    _buildProductListPage(aranan);
                    textController
                        .clear(); //Arama sonrası text inputun içini siliyoruz.
                  });
                },
              ),
            ),
            //bottomNavigationBar:ottomNavigationBar(page: "search", context: context),
          ),
        ]),
      ),
    );
  }

  _buildProductListPage(String aranan) {
    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        if (aranan == _products[index]['name']) {
          return _buildProductListRow(_products, index);
        } else {
          return const SizedBox(height: 0.0);
        }
      },
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
            Container(
              child: Image.asset(_products[index]['imageUrl']),
              width: MediaQuery.of(context).size.width / 2.2,
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(_products[index]['name'],
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  SizedBox(height: 2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _products[index]['currentPrice'].toString() + "TL",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(width: 8.0),
                      Text(_products[index]['originalPrice'].toString() + "TL",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          )),
                      SizedBox(width: 8.0),
                      Text("%" + _products[index]['discount'].toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.cyanAccent,
                          )),
                      SizedBox(width: 8.0),
                    ],
                  ),
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
