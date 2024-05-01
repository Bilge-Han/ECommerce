import 'package:ecommerce/components/bottomNavigation.dart';
import 'package:ecommerce/screens/productDetail.dart';
import 'package:flutter/material.dart';

import 'SQLHelperFavorite.dart';

class AdminFavoriteServicePage extends StatefulWidget {
  @override
  _AdminFavoriteServicePageState createState() =>
      _AdminFavoriteServicePageState();
}
class _AdminFavoriteServicePageState extends State<AdminFavoriteServicePage> {
  List<Map<String, dynamic>> _favorites = [];
  bool _isLoading = true;
  void _refreshProducts() async {
    final data = await SQLHelperFavorite.getItems();
    setState(() {
      _favorites = data;
      _isLoading = false;
    });
  }
  void _deleteItem(int id) async {
    await SQLHelperFavorite.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a product from favorites!'),
    ));
    _refreshProducts();
  }
  void _deleteAllItem() async {
    await SQLHelperFavorite.deleteAllItem();
    _refreshProducts();
  }
  @override
  void initState() {
    super.initState();
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
                title: const Text('Favorilerim'),
                backgroundColor: Colors.blueGrey,
              ),
              body: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: _favorites.length,
                      itemBuilder: (context, index) => Card(
                        color: Colors.red[300],
                        margin: const EdgeInsets.all(10),
                        child: Container(
                          child: ListTile(
                            title: Text(_favorites[index]['name']),
                            subtitle: Text(
                                _favorites[index]['currentPrice'].toString() +
                                    "TL"),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () =>
                                        _deleteItem(_favorites[index]['id']),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ProductDetail(index, _favorites);
                              }));
                            },
                          ),
                        ),
                      ),
                    ),
            ),
            bottomNavigationBar(page: "search", context: context),
          ],
        ),
      ),
    );
  }
}
