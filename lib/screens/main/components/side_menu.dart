import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/controllers/menu_controller.dart';
import 'package:flutter_blockchain_amin/controllers/auth_controller.dart';
import 'package:flutter_blockchain_amin/models/menu_model.dart';
import 'package:flutter_blockchain_amin/shared/constants.dart';
import 'package:flutter_blockchain_amin/shared/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(),
          ),
          Consumer<MenuController>(
            builder: (context, menuController, child) => DrawerListTile(listOfModel: menuController.menuModelList),
          )
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.listOfModel,
    // required this.press,
  }) : super(key: key);

  final List<MenuModel> listOfModel;
  //final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    List<Widget> ListOfListTile = [];
    for (int i = 0; i < listOfModel.length; i++) {
      ListOfListTile.add(InkWell(
        // hoverColor: Colors.grey.withOpacity(0.3),
        child: Container(
          color: listOfModel[i].isselected!
              ? Colors.grey.withOpacity(0.3)
              : secondaryColor,
          child: ListTile(
            selected: true,
            selectedColor: Colors.grey.shade400,
            onTap: () async {
              if (i != 3) {
                context.read<MenuController>().onChangeSelectedMenu(i);
                if (Responsive.isMobile(context) ||
                    Responsive.isBigMobile(context) ||
                    Responsive.isTablet(context)) Navigator.pop(context);
              } else {
                context.read<AuthController>()
                  ..SignOut().then((value) {
                    context.read<MenuController>().buildMenu();
                  });
              }
            },
            horizontalTitleGap: 0.0,
            leading: SvgPicture.asset(
              listOfModel[i].svgSrc!,
              color: Colors.white54,
              height: 16,
            ),
            title: Text(
              listOfModel[i].title!,
              style: const TextStyle(color: Colors.white54),
            ),
          ),
        ),
      ));
    }
    return Column(
      children: [...ListOfListTile],
    );
  }
}

