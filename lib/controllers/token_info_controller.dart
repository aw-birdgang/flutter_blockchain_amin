import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/token.dart';
import '../services/tokens/repository_token.dart';

class TokenInfoController extends ChangeNotifier {

  RepositoryToken repositoryToken = RepositoryToken();
  List<Token> listToken = [];
  bool isLoading = true;

  TokenInfoController() {
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
