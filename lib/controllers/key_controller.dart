import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/services/key/repository_key.dart';

import '../models/host.dart';
import '../models/kmsKey.dart';
import '../services/host/repository_host.dart';

class KeyController extends ChangeNotifier {

  RepositoryKey repositoryKey = RepositoryKey();
  List<KmsKey> listKmsKeys = [];
  bool isLoading = true;

  KeyController() {
    init();
  }

  Future<void> init() async {
    isLoading = true;
    notifyListeners();
  }


  void getKmsKeys() async {
    try {
      isLoading = true;
      notifyListeners();
      listKmsKeys = await repositoryKey.getKeys();
      for (var element in listKmsKeys) {
        print('getKmsKeys > element :: ' + element.toString());
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }


  void encryptKey(name, type) async {
    try {
      isLoading = true;
      notifyListeners();
      await repositoryKey.encryptKey(name, type);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

}
