import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_blockchain_amin/models/prdouct.dart';
import 'package:flutter_blockchain_amin/services/products/irepository_product.dart';

class RepositoryProduct extends IrepositoryProduct {
  final databasereference = FirebaseFirestore.instance;
  @override
  Future<List<Product>> getProducts() async {
    List<Product> _products = [];
    await databasereference.collection('Products').get().then((value) {
      print("product lenght " + value.docs.length.toString());
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          _products.add(Product.fromJson(element.data()));
        }
      }
    });
    return _products;
  }
}
