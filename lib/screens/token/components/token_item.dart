import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/screens/token/components/token_details.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../models/token.dart';
import '../../../shared/constants.dart';
import '../../../shared/responsive.dart';
import '../../../shared/utils.dart';

class TokenItem extends StatefulWidget {
  TokenItem(this.token, {Key? key}) : super(key: key);
  Token token;

  @override
  State<TokenItem> createState() => _TokenItemState();
}

class _TokenItemState extends State<TokenItem> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    Size size = Utils.getscreensize(context);
    String symbol = widget.token.symbol!;
    String totalSupply = widget.token.totalSupply!;
    String createdAt = widget.token.createdAt!;
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            print("TokenItem > onTap ");
            Navigator.push(context, MaterialPageRoute(builder: (context) => TokenDetails(widget.token)));
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
                        child: Container(
                          height: Responsive.isDesktop(context)
                              ? size.width * 0.14
                              : Responsive.isTablet(context)
                              ? size.width * 0.25
                              : Responsive.isBigMobile(context)
                              ? size.width * 0.4
                              : size.width * .6,
                          clipBehavior: Clip.none,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                              image: const NetworkImage(
                                'https://gpex-api-dev.s3.ap-northeast-3.amazonaws.com/api/resource/token/GPW.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  PopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: secondaryColor,
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
                    EasyRichText(
                      symbol,
                      defaultStyle: TextStyle(fontSize: !Responsive.isDesktop(context) ? 15 : 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    EasyRichText(
                      totalSupply,
                      defaultStyle: TextStyle(color: Colors.green.shade400, fontSize: !Responsive.isDesktop(context) ? 15 : 20),
                      overflow: TextOverflow.ellipsis,
                    ),
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
