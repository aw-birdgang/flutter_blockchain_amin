import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/contract_controller.dart';
import '../../../models/token.dart';
import '../../../shared/constants.dart';
import '../../../shared/responsive.dart';

class TokenDetails extends StatelessWidget {
  TokenDetails(this.token, {Key? key}) : super(key: key);
  Token token;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContractController(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(token.name.toString()),
        ),
        body: _consumer(context),
      ),
    );
  }


  Widget _consumer(BuildContext context) {
    return Consumer<ContractController>(
      builder: (context, contractController, child) {
        return _scaffold(context, contractController);
      },
    );
  }


  Widget _scaffold(BuildContext context, ContractController contractController,) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Details Info",
            style: TextStyle(fontSize: 30),
          ),
          const Divider(
            thickness: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTokenInfo(context, "ID", token.id.toString()),
                    const SizedBox(
                      height: 20,
                    ),
                    getTokenInfo(context, "SYMBOL", token.symbol),
                    const SizedBox(
                      height: 20,
                    ),
                    getTokenInfo(context, "NAME", token.name),
                    const SizedBox(
                      height: 20,
                    ),
                    getTokenInfo(context, "TOTAL_SUPPLY", token.totalSupply),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  getTokenInfo (BuildContext context, title, value) {
    return Row(
      children: [
        SizedBox(
            width: Responsive.isDesktop(context) ? 150 : 100,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: !Responsive.isDesktop(context)
                      ? 15
                      : 25),
            )),
        const SizedBox(
          width: 20,
        ),
        Text(
          value,
          style: TextStyle(
              color: Colors.green.shade300,
              fontSize: !Responsive.isDesktop(context) ? 15 : 25),
        ),
      ],
    );
  }


}