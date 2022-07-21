import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/token_list_controller.dart';
import '../../shared/constants.dart';
import '../../shared/responsive.dart';
import 'components/token_add.dart';
import 'components/token_item.dart';

class TokenListScreen extends StatefulWidget {
  const TokenListScreen({Key? key}) : super(key: key);
  @override
  State<TokenListScreen> createState() => _TokenListScreenState();
}

class _TokenListScreenState extends State<TokenListScreen> {
  late TokenListController tokenListController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TokenListController()..getTokens(),
      child: _consumer(context),
    );
  }

  Widget _consumer(BuildContext context) {
    return Consumer<TokenListController>(
      builder: (context, tokenListController, child) {
        this.tokenListController = tokenListController;
        return _scaffold(context);
      },
    );
  }

  Widget _scaffold(BuildContext context,) {
    return RefreshIndicator(
      backgroundColor: primaryColor,
      color: secondaryColor,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1500));
      },
      child: contentView(context,),
    );
  }

  Widget contentView (BuildContext context) {
    return tokenListController.isLoading ? const CircularProgressIndicator()
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
                // context.watch<TokenListController>().getTokens();
                tokenListController.getTokens();
              },
              icon: const Icon(Icons.swap_horiz),
              label: const Text("새로고침"),
            ),
            const SizedBox(width: 10,),
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
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: context.watch<TokenListController>().listToken.length,
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
