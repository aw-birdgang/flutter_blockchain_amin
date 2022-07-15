import 'package:flutter_blockchain_amin/models/prdouct.dart';

abstract class IrepositoryProduct {
  Future<List<Product>> getProducts();
}
