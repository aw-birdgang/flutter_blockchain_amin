import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../models/kmsKey.dart';
import '../../../shared/components/default_text_info_row.dart';
import '../../../shared/constants.dart';
import '../../../shared/utils.dart';

class KeyItem extends StatefulWidget {
  KeyItem(this.kmsKey, {Key? key}) : super(key: key);
  KmsKey kmsKey;

  @override
  State<KeyItem> createState() => _KeyItemState();
}

class _KeyItemState extends State<KeyItem> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    Size size = Utils.getscreensize(context);
    int id = widget.kmsKey.id!;
    String cipher = widget.kmsKey.cipher!;
    String tag = widget.kmsKey.tag!;
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            print("KeyItem > onTap ");
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
                    getTextInfoRow(context, "ID", id.toString()),
                    const SizedBox(
                      height: 5,
                    ),
                    getTextInfoRow(context, "CIPHER", cipher),
                    const SizedBox(
                      height: 5,
                    ),
                    getTextInfoRow(context, "TAG", tag),
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
