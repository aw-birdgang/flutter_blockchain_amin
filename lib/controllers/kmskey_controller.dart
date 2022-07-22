import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/services/key/repository_key.dart';

import '../models/kmsKey.dart';

class KmsKeyController extends ChangeNotifier {

  RepositoryKey repositoryKey = RepositoryKey();
  List<KmsKey> listKmsKeys = [];
  late KmsKey kmsKey;
  bool isLoading = true;

  KmsKeyController() {
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

  void encryptKey(KmsKey request, {response}) async {
    try {
      isLoading = true;
      notifyListeners();
      kmsKey = await repositoryKey.encryptKey(request);
      isLoading = false;
      notifyListeners();
      response(kmsKey);
    } catch (e) {
      print(e);
    }
  }

}
