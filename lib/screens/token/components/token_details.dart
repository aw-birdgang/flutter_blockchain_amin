import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/screens/token/components/token_balance.dart';
import 'package:flutter_blockchain_amin/shared/components/default_text_info_row.dart';
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
          backgroundColor: secondaryColor,
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
          tokenInfo(context,),
          Row(
            children: [
              btnGetBalance(context,),
              btnMint(context,),
            ],
          ),
        ],
      ),
    );
  }

  Widget tokenInfo (BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTextInfoRow(context, "ID", token.id.toString()),
                  getTextInfoRow(context, "SYMBOL", token.symbol),
                  getTextInfoRow(context, "NAME", token.name),
                  getTextInfoRow(context, "TOTAL_SUPPLY", token.totalSupply),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }

  Widget btnGetBalance (BuildContext context,) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: ElevatedButton(
        child: const Text("GET BALANCE"),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
          ),
        ),
        onPressed: () {
          print("btnGetBalance > onPressed ");
          Navigator.push(context, MaterialPageRoute(builder: (context) => TokenBalance(token)));
        },
      ),
    );
  }

  Widget btnMint (BuildContext context,) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: ElevatedButton(
        child: const Text("MINT"),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
          ),
        ),
        onPressed: () {
          print("btnMint > onPressed ");
        },
      ),
    );
  }

}