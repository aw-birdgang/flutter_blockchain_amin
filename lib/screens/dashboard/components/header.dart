import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/controllers/auth_controller.dart';
import 'package:flutter_blockchain_amin/controllers/menu_controller.dart';
import 'package:flutter_blockchain_amin/shared/responsive.dart';
import 'package:provider/provider.dart';

import '../../../shared/constants.dart';

class Header extends StatelessWidget {
  final Function fct;
  const Header({Key? key, required this.fct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                fct();
              }),
        if (!Responsive.isMobile(context))
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${context.watch<MenuController>().screens_title[context.watch<MenuController>().currentSelectedIndex]}",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  "${context.watch<MenuController>().screens_description[context.watch<MenuController>().currentSelectedIndex]}",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(flex: 2, child: SearchField()),
        const ProfileCard(),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Consumer<AuthController>(
        builder: (context, controller, child) {
          return Row(
            children: [
              Image.asset(
                "assets/images/profile_pic.jpg",
                height: 38,
              ),
              if (!Responsive.isMobile(context))
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: Text(controller.currentuserModel!.email.toString())),
              const Icon(Icons.keyboard_arrow_down),
            ],
          );
        },
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
  }) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
      },
      controller: searchController,
      decoration: const InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}



// class Logout extends StatelessWidget {
//   const Logout({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(defaultPadding),
//       child: defaultButton(
//           text: "Sign Out",
//           height: 50,
//           onpress: () {
//             context.read<AuthController>()
//               ..SignOut().then((value) {
//                 context.read<MenuController>()..buildMenu();
//               });
//           }
//       ),
//     );
//   }
// }

