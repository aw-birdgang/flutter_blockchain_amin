import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/shared/components/default_text_info_row.dart';
import 'package:provider/provider.dart';

import '../../../controllers/contract_controller.dart';
import '../../../models/token.dart';
import '../../../shared/constants.dart';
import '../../../shared/responsive.dart';

class TokenBalance extends StatefulWidget {
  TokenBalance(this.token, {Key? key}) : super(key: key);
  Token token;
  @override
  State<TokenBalance> createState() => _TokenBalanceState();
}

class _TokenBalanceState extends State<TokenBalance> {
  late ContractController contractController;
  final privateKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContractController(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.token.name.toString()),
          backgroundColor: secondaryColor,
        ),
        body: _consumer(context),
      ),
    );
  }

  Widget _consumer(BuildContext context) {
    return Consumer<ContractController>(
      builder: (context, contractController, child) {
        this.contractController = contractController;
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
          getBalance(context),
        ],
      ),
    );
  }

  getBalance(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: privateKeyController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'input private key',
              suffixIcon: IconButton(
                onPressed: () {
                  print("getBalance > onPressed ");
                  setState(() {
                    contractController.getBalance(widget.token.symbol, privateKeyController.text);
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: getTextInfoRow(context, "BALANCE", contractController.balance)
        )
      ],
    );
  }

}