import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../../common/object_util.dart';
import '../../../controllers/host_controller.dart';
import '../../../models/host.dart';
import '../../../shared/constants.dart';
import '../../../shared/responsive.dart';

class HostAdd extends StatefulWidget {
  const HostAdd({Key? key}) : super(key: key);
  @override
  State<HostAdd> createState() => _HostAddState();
}

class _HostAddState extends State<HostAdd> {
  late HostController hostController;
  final nameController = TextEditingController();
  final typeController = TextEditingController();

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HostController(),
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
    return Consumer<HostController>(
      builder: (context, hostController, child) {
        this.hostController = hostController;
        return _scaffold(context, hostController);
      },
    );
  }

  Widget _scaffold(BuildContext context, HostController hostController,) {
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
          getType(context),
          getExposeYn(context),
          getBtnAddHost(context),
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
          hintText: 'input host name',
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
            Host host = Host();
            host.name = nameController.text;
            host.type = typeController.text;
            host.exposeYn = status;
            hostController.registerHost(host, response: (result) {
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