import 'package:flutter_blockchain_amin/models/UserModel.dart';
import 'package:flutter_blockchain_amin/models/menu_model.dart';
import 'package:flutter_blockchain_amin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_blockchain_amin/screens/login/login_screen.dart';
import 'package:flutter_blockchain_amin/shared/constants.dart';
import 'package:flutter/material.dart';

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
  final GlobalKey<ScaffoldState> getviewOrderscaffoldKey =
  GlobalKey<ScaffoldState>();

  void main_controlMenu() {
    if (!getscaffoldKey.currentState!.isDrawerOpen) {
      getscaffoldKey.currentState!.openDrawer();
    }
  }

  void viewOrder_controlMenu() {
    if (!getviewOrderscaffoldKey.currentState!.isDrawerOpen) {
      getviewOrderscaffoldKey.currentState!.openDrawer();
    }
  }

  MenuController(this._authProvider) {
    buildMenu();
  }

  final _screens = [
    const DashboardScreen(),
    const TokenListScreen(),
  ];

  final _screens_title = [
    'Dashboard',
    'Token List',
  ];

  final _screens_description = [
    '홈',
    '토큰 목록',
  ];

  final List<MenuModel> _offline_menuModelList = [
    MenuModel("login", "assets/icons/menu_login.svg")
  ];

  final List<MenuModel> _menuModelList = [
    MenuModel("Dashboard", "assets/icons/menu_dashbord.svg", isselected: true),
    MenuModel("Tokens", "assets/icons/menu_tran.svg"),
    // MenuModel("Products", "assets/icons/menu_task.svg"),
    // MenuModel("Logout", "assets/icons/menu_logout.svg"),
  ];

  List<MenuModel> menuModelList = [];
  var screens_title = [];
  var screens_description = [];
  var screens = [];
  void buildMenu() {
    screens_title = _screens_title;
    screens_description = _screens_description;
    menuModelList = _menuModelList;
    screens = _screens;
    notifyListeners();
  }
}
