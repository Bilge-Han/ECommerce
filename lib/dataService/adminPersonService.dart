import 'package:flutter/material.dart';
import 'SQLHelperPerson.dart';

class AdminPersonServicePage extends StatefulWidget {
  const AdminPersonServicePage({Key? key}) : super(key: key);

  @override
  _AdminPersonServicePagePageState createState() =>
      _AdminPersonServicePagePageState();
}

class _AdminPersonServicePagePageState extends State<AdminPersonServicePage> {
  List<Map<String, dynamic>> _persons = [];
  var yetkiler = ["Admin", "Müşteri"];
  var selectedYetki = "Admin";
  bool _isLoading = true;
  void _refreshPersons() async {
    final data = await SQLHelperPerson.getItems();
    setState(() {
      _persons = data;
      _isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _refreshPersons();
  }
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _yetkiController = TextEditingController();
  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _persons.firstWhere((element) => element['id'] == id);
      _userNameController.text = existingJournal['userName'];
      _passwordController.text = existingJournal['password'];
      _yetkiController.text = existingJournal['yetki'];
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
                  TextField( controller: _userNameController,
                      decoration: const InputDecoration(hintText: 'userName')),
                  const SizedBox(height: 20),
                  TextField( controller: _passwordController,
                      decoration: const InputDecoration(hintText: 'password')),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    items: yetkiler.map((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    value: selectedYetki,
                    onChanged: (var value) {
                      setState(() {
                        selectedYetki = value.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (id == null) {
                        await _addItem();
                      }
                      if (id != null) {
                        await _updateItem(id);
                      }
                      _userNameController.text = '';
                      _passwordController.text = '';
                      _yetkiController.text = '';
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }
  Future<void> _addItem() async {
    await SQLHelperPerson.createItem(
        _userNameController.text, _passwordController.text, selectedYetki);
    _refreshPersons();
  }
  Future<void> _updateItem(int id) async {
    await SQLHelperPerson.updateItem(
        id, _userNameController.text, _passwordController.text, selectedYetki);
    _refreshPersons();
  }
  void _deleteItem(int id) async {
    await SQLHelperPerson.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a product!'),
    ));
    _refreshPersons();
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
              itemCount: _persons.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(_persons[index]['userName']),
                  subtitle: Text(_persons[index]['yetki'].toString()),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showForm(_persons[index]['id']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteItem(_persons[index]['id']),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
