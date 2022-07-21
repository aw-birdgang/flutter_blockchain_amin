import 'package:flutter/material.dart';

import '../models/host.dart';
import '../services/host/repository_host.dart';

class HostController extends ChangeNotifier {

  RepositoryHost repositoryHost = RepositoryHost();
  List<Host> listHost = [];
  late Host host;
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

  void registerHost(Host request, {response}) async {
    try {
      isLoading = true;
      notifyListeners();
      host = await repositoryHost.registerHost(request);
      isLoading = false;
      notifyListeners();
      response(host);
    } catch (e) {
      print(e);
    }
  }

}
