import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/shared/components/default_text_info_row.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../models/host.dart';
import '../../../shared/constants.dart';
import '../../../shared/utils.dart';

class HostItem extends StatefulWidget {
  HostItem(this.host, {Key? key}) : super(key: key);
  Host host;

  @override
  State<HostItem> createState() => _HostItemState();
}

class _HostItemState extends State<HostItem> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    Size size = Utils.getscreensize(context);
    String name = widget.host.name!;
    String accessToken = widget.host.accessToken!;
    String type = widget.host.type!;
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            print("HostItem > onTap ");
            // Navigator.push(context, MaterialPageRoute(builder: (context) => TokenDetails(widget.token)));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                  PopupMenuButton(
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        color: whiteColor,
                      ),
                      color: secondaryColor,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {},
                          child: const Text('Edit'),
                          value: 1,
                        ),
                        PopupMenuItem(
                          onTap: () {},
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                          value: 2,
                        ),
                      ]
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTextInfoRow(context, "NAME", name),
                    const SizedBox(
                      height: 5,
                    ),
                    getTextInfoRow(context, "ACCESS TOKEN", accessToken)
                  ],
                ),
              ),

              const Divider(
                thickness: 2,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
