import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/services/contract/repository_contract.dart';

import '../models/balance.dart';

class ContractController extends ChangeNotifier {

  RepositoryContract repositoryContract = RepositoryContract();
  late String balance = "0";
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
      Balance balance = await repositoryContract.getBalance(symbol, address);
      print('getBalance > balance :: ' + balance.toString());
      this.balance = balance.balance!;
      print('getBalance > this.balance :: ' + this.balance);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

}
