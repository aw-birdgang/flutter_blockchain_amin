import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../../controllers/token_controller.dart';
import '../../../models/token.dart';
import '../../../shared/constants.dart';
import '../../../shared/responsive.dart';

class TokenAdd extends StatefulWidget {
  const TokenAdd({Key? key}) : super(key: key);
  @override
  State<TokenAdd> createState() => _TokenAddState();
}

class _TokenAddState extends State<TokenAdd> {
  late TokenController tokenController;
  final nameController = TextEditingController();
  final symbolController = TextEditingController();
  final totalSupplyController = TextEditingController();
  final decimalsController = TextEditingController();
  final typeController = TextEditingController();

  bool status = false;

  // totalSupply = getItemFromMapForStr(map, "totalSupply");
  // decimals = getItemFromMapForDouble(map, "decimals");
  // type = getItemFromMapForStr(map, "type");
  // exposeYn = getItemFromMapForBool(map, "exposeYn");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TokenController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(""),
          backgroundColor: secondaryColor,
        ),
        body: _consumer(context),
      ),
    );
  }

  Widget _consumer(BuildContext context) {
    return Consumer<TokenController>(
      builder: (context, tokenController, child) {
        this.tokenController = tokenController;
        return _scaffold(context, tokenController);
      },
    );
  }

  Widget _scaffold(BuildContext context, TokenController tokenController,) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getName(context),
          getSymbol(context),
          getTotalSupply(context),
          getDecimals(context),
          getType(context),
          getExposeYn(context),
          getBtnAddToken(context),
        ],
      ),
    );
  }

  getName(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextField(
        controller: nameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'input token name',
        ),
      ),
    );
  }

  getSymbol(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextField(
        controller: symbolController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'input symbol name',
        ),
      ),
    );
  }

  getTotalSupply(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextField(
        controller: totalSupplyController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'input token total supply',
        ),
      ),
    );
  }

  getDecimals(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextField(
        controller: decimalsController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'input decimal',
        ),
      ),
    );
  }

  getType(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextField(
        controller: typeController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'input type',
        ),
      ),
    );
  }

  getExposeYn(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          EasyRichText(
            "노출 여부",
            defaultStyle: TextStyle(
              color: Colors.green.shade300,
              fontSize: !Responsive.isDesktop(context) ? 10 : 15,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 10,),
          FlutterSwitch(
            value: status,
            onToggle: (val) {
              setState(() {
                status = val;
              });
            },
          ),
        ],
      ),
    );
  }


  getBtnAddToken(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
          ),
        ),
        onPressed: () {
          try {
            Token token = Token();
            token.name = nameController.text;
            token.symbol = symbolController.text;
            token.totalSupply = totalSupplyController.text;
            token.decimals = double.parse(decimalsController.text);
            token.type = typeController.text;
            token.exposeYn = status;
            tokenController.createToken(token);
          } catch (error) {
            print(error);
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Token"),
      ),
    );
  }

}