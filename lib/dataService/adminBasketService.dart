import 'package:ecommerce/Screens/productDetail.dart';
import 'package:flutter/material.dart';
import 'SQLHelperBasket.dart';
class AdminBasketServicePage extends StatefulWidget {
  @override
  _AdminBasketServicePageState createState() => _AdminBasketServicePageState();
}
class _AdminBasketServicePageState extends State<AdminBasketServicePage> {
  List<Map<String, dynamic>> _baskets = [];
  bool _isLoading = true;
  void _refreshProducts() async {
    final data = await SQLHelperBasket.getItems();
    setState(() {
      _baskets = data;
      _isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _refreshProducts(); 
  }
  void _deleteItem(int id) async {
    await SQLHelperBasket.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a product from basket!'),
    ));
    _refreshProducts();
  }

  void _deleteAllItem() async {
    await SQLHelperBasket.deleteAllItem();
    _refreshProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text('Sepetim'),
                backgroundColor: Colors.blueGrey,
              ),
              body: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: _baskets.length,
                      itemBuilder: (context, index) => Card(
                        color: Colors.green[200],
                        margin: const EdgeInsets.all(10),
                        child: Container(
                          child: ListTile(
                            title: Text(_baskets[index]['name']),
                            subtitle: Text(
                                _baskets[index]['currentPrice'].toString() +
                                    "TL"),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () =>
                                        _deleteItem(_baskets[index]['id']),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ProductDetail(index, _baskets);
                              }));
                            },
                          ),
                        ),
                      ),
                    ),
              bottomNavigationBar: _buildBottomNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }

  _buildBottomNavigationBar() {
    double totalPrice = 0;
    for (var i = 0; i < _baskets.length; i++) {
      totalPrice = totalPrice + _baskets[i]['currentPrice'];
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: RaisedButton(
              onPressed: () {},
              color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.price_check_sharp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    "Toplam Fiyat  $totalPrice TL",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: RaisedButton(
              onPressed: () {
                _deleteAllItem();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Successfully ordered!'),
                  backgroundColor: Colors.lightGreen,
                ));
              },
              color: Colors.greenAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.border_outer_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    "Sipariş Ver",
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
