import 'package:ecommerce/dataService/SQLHelperProduct.dart';
import 'package:flutter/material.dart';

class AdminProductServicePage extends StatefulWidget {
  const AdminProductServicePage({Key? key}) : super(key: key);
  @override
  _AdminProductServicePageState createState() =>
      _AdminProductServicePageState();
}
class _AdminProductServicePageState extends State<AdminProductServicePage> {
  List<Map<String, dynamic>> _products = [];
  final List<String> categories = [
    "Bilgisayarlar",
    "Aksesuarlar",
    "Cep Telefonlari",
    "Akilli Esyalar",
    "Giyim",
    "Mutfak"
  ];
  var selectedCategory = "Bilgisayarlar";
  bool _isLoading = true;
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
    _refreshProducts(); 
  }
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _currentPriceController = TextEditingController();
  final TextEditingController _originalPriceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _imageUrl2Controller = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _products.firstWhere((element) => element['id'] == id);
      _nameController.text = existingJournal['name'];
      _currentPriceController.text = existingJournal['currentPrice'].toString();
      _originalPriceController.text =
          existingJournal['originalPrice'].toString();
      _discountController.text = existingJournal['discount'].toString();
      _imageUrlController.text = existingJournal['imageUrl1'];
      _imageUrl2Controller.text = existingJournal['imageUrl2'];
      _categoryController.text = existingJournal['category'];
    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  //const SizedBox(height: 10),
                  TextField(
                    controller: _currentPriceController,
                    decoration: const InputDecoration(hintText: 'currentPrice'),
                  ),
                  //const SizedBox(height: 15),
                  TextField(
                    controller: _originalPriceController,
                    decoration:
                        const InputDecoration(hintText: 'originalPrice'),
                  ),
                  //const SizedBox(height: 15),
                  TextField(
                    controller: _discountController,
                    decoration: const InputDecoration(hintText: 'discount'),
                  ),
                  //const SizedBox(height: 15),
                  TextField(
                    controller: _imageUrlController,
                    decoration: const InputDecoration(hintText: 'imageUrl1'),
                  ),
                  //const SizedBox(height: 15),
                  TextField(
                    controller: _imageUrl2Controller,
                    decoration: const InputDecoration(hintText: 'imageUrl2'),
                  ),
                  //const SizedBox(height: 15),
                  Row(
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.lightBlueAccent, width: 5)),
                          child: DropdownButton<String>(
                            value: selectedCategory,
                            iconSize: 30,
                            icon: const Icon(
                              Icons.arrow_drop_down_circle_sharp,
                              color: Colors.lightBlueAccent,
                            ),
                            dropdownColor: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                            items: categories.map((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (var value) {
                              setState(() {
                                selectedCategory = value.toString();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (id == null) {
                        await _addItem();
                      }
                      if (id != null) {
                        await _updateItem(id);
                      }
                      _nameController.text = '';
                      _currentPriceController.text = '';
                      _originalPriceController.text = '';
                      _discountController.text = '';
                      _imageUrlController.text = '';
                      _imageUrl2Controller.text = '';
                      _categoryController.text = '';
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }
  Future<void> _addItem() async {
    await SQLHelperProduct.createItem(
        _nameController.text,
        double.parse(_currentPriceController.text),
        double.parse(_originalPriceController.text),
        double.parse(_discountController.text),
        _imageUrlController.text,
        _imageUrl2Controller.text,
        selectedCategory);
    _refreshProducts();
  }
  Future<void> _updateItem(int id) async {
    await SQLHelperProduct.updateItem(
        id,
        _nameController.text,
        double.parse(_currentPriceController.text),
        double.parse(_originalPriceController.text),
        double.parse(_discountController.text),
        _imageUrlController.text,
        _imageUrl2Controller.text,
        _categoryController.text);
    _refreshProducts();
  }
  void _deleteItem(int id) async {
    await SQLHelperProduct.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a product!'),
    ));
    _refreshProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BilgeZone'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text(_products[index]['name']),
                    subtitle: Text(_products[index]['currentPrice'].toString() +
                        " " +
                        _products[index]['category']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showForm(_products[index]['id']),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _deleteItem(_products[index]['id']),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
