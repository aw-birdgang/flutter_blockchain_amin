import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TokenController extends ChangeNotifier {

  bool isLoading = true;

  TokenController() {
    init();
  }

  Future<void> init() async {
    isLoading = true;
    notifyListeners();
  }

  void requestTokens() async {
    try {
      String api = dotenv.get('API_URL');
      var response = await Dio().get('$api/v1/tokens');
      print(response);
    } catch (e) {
      print(e);
    }
  }

}
