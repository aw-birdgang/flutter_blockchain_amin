import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/services/contract/repository_contract.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/token.dart';
import '../services/tokens/repository_token.dart';

class ContractController extends ChangeNotifier {

  RepositoryContract repositoryContract = RepositoryContract();
  dynamic balance;
  bool isLoading = true;

  ContractController() {
    init();
  }

  Future<void> init() async {
    isLoading = true;
    notifyListeners();
  }

  void getBalance(symbol, address) async {
    try {
      isLoading = true;
      notifyListeners();
      balance = await repositoryContract.getBalance(symbol, address);
      print('getBalance > balance :: ' + balance.toString());
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

}
