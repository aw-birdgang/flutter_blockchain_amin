import 'package:flutter_blockchain_amin/controllers/MenuController.dart';
import 'package:flutter_blockchain_amin/controllers/auth_controller.dart';
import 'package:flutter_blockchain_amin/screens/dashboard/components/header.dart';
import 'package:flutter_blockchain_amin/shared/constants.dart';
import 'package:flutter_blockchain_amin/shared/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<AuthController>(context);

    return Scaffold(
      key: context.read<MenuController>().getscaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: const SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      if (authprovider.currentuserModel != null)
                        Header(fct: () {
                          context.read<MenuController>().main_controlMenu();
                        }),
                      const SizedBox(height: defaultPadding),
                      context.watch<MenuController>().screens[
                      context.watch<MenuController>().currentSelectedIndex],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
