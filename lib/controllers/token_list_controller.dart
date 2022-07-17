import 'package:flutter/material.dart';

import '../models/token.dart';
import '../services/tokens/repository_token.dart';

class TokenListController extends ChangeNotifier {

  RepositoryToken repositoryToken = RepositoryToken();
  List<Token> listToken = [];
  bool isLoading = true;

  TokenListController() {
    init();
  }

  Future<void> init() async {
    isLoading = true;
    notifyListeners();
  }

  void getTokens() async {
    try {
      isLoading = true;
      notifyListeners();
      listToken = await repositoryToken.getTokens();
      for (var element in listToken) {
        print('getTokens > element :: ' + element.toString());
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

}
