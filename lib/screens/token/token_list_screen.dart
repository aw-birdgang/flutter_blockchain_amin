import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/token_list_controller.dart';
import '../../shared/constants.dart';
import '../../shared/responsive.dart';
import 'components/token_add.dart';
import 'components/token_item.dart';

class TokenListScreen extends StatelessWidget {
  const TokenListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<TokenListController>().isLoading
        ? const CircularProgressIndicator()
        : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                  vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                print("TokenListScreen > onPressed ");
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TokenAdd()));
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New"),
            ),
          ],
        ),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
            context.watch<TokenListController>().listToken.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context)
                  ? 4
                  : Responsive.isTablet(context)
                  ? 3
                  : Responsive.isBigMobile(context)
                  ? 2
                  : 1,
              childAspectRatio: Responsive.isMobile(context) ? 1.1 : 0.8,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
            ),
            itemBuilder: (context, index) {
              return TokenItem(context
                  .watch<TokenListController>()
                  .listToken[index]);
            }),
      ],
    );
  }
}
