import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/models/kmsKey.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../../common/object_util.dart';
import '../../../controllers/kmskey_controller.dart';
import '../../../shared/constants.dart';
import '../../../shared/responsive.dart';

class KmsKeyAdd extends StatefulWidget {
  const KmsKeyAdd({Key? key}) : super(key: key);
  @override
  State<KmsKeyAdd> createState() => _KmsKeyAddState();
}

class _KmsKeyAddState extends State<KmsKeyAdd> {
  late KmsKeyController kmsKeyController;
  final nameController = TextEditingController();
  final typeController = TextEditingController();

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => KmsKeyController(),
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
    return Consumer<KmsKeyController>(
      builder: (context, kmsKeyController, child) {
        this.kmsKeyController = kmsKeyController;
        return _scaffold(context, kmsKeyController);
      },
    );
  }

  Widget _scaffold(BuildContext context, KmsKeyController kmsKeyController,) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getOriginalText(context),
          getTag(context),
          getExposeYn(context),
          getBtnAddHost(context),
        ],
      ),
    );
  }

  getOriginalText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextField(
        controller: nameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'input original text',
        ),
      ),
    );
  }

  getTag(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextField(
        controller: typeController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'input tag',
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


  getBtnAddHost(BuildContext context) {
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
            KmsKey kmsKey = KmsKey();
            kmsKey.originalText = nameController.text;
            kmsKey.tag = typeController.text;
            kmsKey.exposeYn = status;
            kmsKeyController.encryptKey(kmsKey, response: (result) {
              if (isExists(result)) {
                Navigator.pop(context);
              }
            });
          } catch (error) {
            print(error);
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Host"),
      ),
    );
  }

}
