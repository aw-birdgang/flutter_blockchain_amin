import 'package:flutter/material.dart';

import '../models/token.dart';
import '../services/tokens/repository_token.dart';

class TokenController extends ChangeNotifier {

  RepositoryToken repositoryToken = RepositoryToken();
  List<Token> listToken = [];
  late Token token;
  bool isLoading = true;

  TokenController() {
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

  void createToken(Token token) async {
    try {
      isLoading = true;
      notifyListeners();
      token = await repositoryToken.createToken(token);
      print('createToken > token :: ' + token.toString());
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

}
