import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utilities/constants.dart';
import 'package:flutter/material.dart';

class ProductListRow extends StatelessWidget {
  List<Map<String, dynamic>> products = [];
  ProductListRow({required this.products});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildProductItemCard(context),
        _buildProductItemCard(context)
      ],
    );
  }

  _buildProductItemCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Constants.ROUTE_PRODUCT_DETAIL);
      },
      child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Container(
                    child: Image.asset("assets/images/kazak.jpeg"),
                    height: 250.0,
                    width: MediaQuery.of(context).size.width / 2.2,
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(products[index]['name'],
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                        SizedBox(height: 2.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              products[index]['currentPrice'].toString(),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(width: 8.0),
                            Text(products[index]['originalPrice'].toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                )),
                            SizedBox(width: 8.0),
                            Text(products[index]['discount'].toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.cyanAccent,
                                )),
                            SizedBox(width: 8.0),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            );
          }),
    );
  }
}







// class Notes {
//   // int id; // her not'a kolayca ulaşmak adına bir id,
//   // String title; // her not için bir başlık,
//   // String description; //her not için bir açıklama tanımladık.
//   late String name;
//   late int currentPrice;
//   late int originalPrice;
//   late int discount;
//   late String imageUrl;

//   // Notes(this.title, this.description); // Constructor'ımızı oluşturduk.
//   // //Ekleme işlemlerinde direkt olarak id atadığı için id kullanmadık.
//   // Notes.withId(this.id, this.title, this.description);
//   // Silme ve güncelleme gibi işlemler için ise id'li bir constructor oluşturduk.

// //Sqlite'da devamlı "map"ler ile çalışacağımız için yardımcı methodlarımızı hazırlayalım.
// //Verilerimizi okurken de map olarak okuyacağız, nesnemizi yazdırırken de map'e çevireceğiz.

//   Map<dynamic, dynamic> toMap() {
//     var map = Map<String, dynamic>(); //Geçici bir map nesnesi
//     map["name"] = name;
//     map["currentPrice"] = currentPrice;
//     map["originalPrice"] = originalPrice;
//     map["discount"] = discount;
//     map["imageUrl"] = imageUrl;
//     return map; //Bu mapimizi döndürüyoruz.
//   }

//   Notes.fromMap(Map<dynamic, dynamic> map) {
//     this.name = map["name"];
//     this.currentPrice = map["currentPrice"];
//     this.originalPrice = map["originalPrice"];
//     this.discount = map["discount"];
//     this.imageUrl = map["imageUrl"];
//   }
// }

// class Anket {
//   String name;
//   int currentPrice;
//   int originalPrice;
//   int discount;
//   String imageUrl;
//   String category;
//   DocumentReference reference;

//   Anket.fromMap(
//     Map<String, dynamic> map,
//   )   : name = map["name"],
//         currentPrice = map["currentPrice"],
//         originalPrice = map["originalPrice"],
//         discount = map["discount"],
//         imageUrl = map["imageUrl"],
//         category = map["category"];

//   // Anket.fromSnapshot(DocumentSnapshot snapshot)
//   //     : this.fromMap(snapshot.data(), reference: snapshot.reference);
// }
