import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/models/menu_model.dart';
import 'package:flutter_blockchain_amin/screens/dashboard/dashboard_screen.dart';

import '../screens/client/client_list_screen.dart';
import '../screens/kmsKey/kmsKey_list_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/token/token_list_screen.dart';
import 'auth_controller.dart';

class MenuController extends ChangeNotifier {
  final AuthController? _authProvider;

  int currentSelectedIndex = 0;

  void onChangeSelectedMenu(index) {
    print(index);
    for (int i = 0; i < menuModelList.length; i++) {
      if (i == index) {
        print(menuModelList[i].title.toString() + " selected");
        menuModelList[i].isselected = true;
      } else {
        menuModelList[i].isselected = false;
      }
    }
    currentSelectedIndex = index;
    // menuModelList.forEach((element) {
    //   print(element.title.toString() + " - " + element.isselected.toString());
    // });
    notifyListeners();
  }

  final GlobalKey<ScaffoldState> getscaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> getviewOrderscaffoldKey = GlobalKey<ScaffoldState>();

  void mainControlMenu() {
    if (!getscaffoldKey.currentState!.isDrawerOpen) {
      getscaffoldKey.currentState!.openDrawer();
    }
  }

  void viewOrderControlMenu() {
    if (!getviewOrderscaffoldKey.currentState!.isDrawerOpen) {
      getviewOrderscaffoldKey.currentState!.openDrawer();
    }
  }

  MenuController(this._authProvider) {
    buildMenu();
  }

  final _offline_screen = [const LoginScreen()];

  final _screens = [
    // const DashboardScreen(),
    const TokenListScreen(),
    const ClientListScreen(),
    const KmsKeyListScreen(),
  ];

  final _offline_screens_title = ['Login'];
  final _screens_title = [
    // 'Dashboard',
    'Token List',
    'Host List',
    'Key List',
  ];

  final _screens_description = [
    // '홈',
    '토큰 목록',
    '호스트 목록',
    '키 목록',
  ];

  final List<MenuModel> _offline_menuModelList = [
    MenuModel("login", "assets/icons/menu_login.svg")
  ];

  final List<MenuModel> _menuModelList = [
    // MenuModel("Dashboard", "assets/icons/menu_dashbord.svg", isselected: true),
    MenuModel("Tokens", "assets/icons/menu_tran.svg", isselected: true),
    MenuModel("Clients", "assets/icons/menu_task.svg"),
    MenuModel("Keys", "assets/icons/menu_store.svg"),
    MenuModel("Logout", "assets/icons/menu_logout.svg"),
  ];

  List<MenuModel> menuModelList = [];
  var screens_title = [];
  var screens_description = [];
  var screens = [];
  void buildMenu() {
    if (_authProvider != null && _authProvider!.currentuserModel == null) {
      screens_title = _offline_screens_title;
      menuModelList = _offline_menuModelList;
      screens = _offline_screen;
    } else {
      screens_title = _screens_title;
      screens_description = _screens_description;
      menuModelList = _menuModelList;
      screens = _screens;
    }
    // screens_title = _screens_title;
    // screens_description = _screens_description;
    // menuModelList = _menuModelList;
    // screens = _screens;
    notifyListeners();
  }
}
