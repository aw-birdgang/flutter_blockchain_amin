import 'package:flutter/material.dart';

import '../models/host.dart';
import '../services/host/repository_host.dart';

class HostController extends ChangeNotifier {

  RepositoryHost repositoryHost = RepositoryHost();
  List<Host> listHost = [];
  bool isLoading = true;

  HostController() {
    init();
  }

  Future<void> init() async {
    isLoading = true;
    notifyListeners();
  }


  void getHosts() async {
    try {
      isLoading = true;
      notifyListeners();
      listHost = await repositoryHost.getHosts();
      for (var element in listHost) {
        print('getHosts > element :: ' + element.toString());
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }


  void registerHost(name, type) async {
    try {
      isLoading = true;
      notifyListeners();
      await repositoryHost.registerHost(name, type);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

}
