import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/host_controller.dart';
import '../../shared/constants.dart';
import '../../shared/responsive.dart';
import 'components/host_add.dart';
import 'components/host_item.dart';

class HostListScreen extends StatefulWidget {
  const HostListScreen({Key? key}) : super(key: key);
  @override
  State<HostListScreen> createState() => _HostListScreenState();
}

class _HostListScreenState extends State<HostListScreen> {

  late HostController hostController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HostController()..getHosts(),
      child: _consumer(context),
    );
  }

  Widget _consumer(BuildContext context) {
    return Consumer<HostController>(
      builder: (context, hostController, child) {
        this.hostController = hostController;
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
    return context.watch<HostController>().isLoading
        ? const CircularProgressIndicator()
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
                print("HostListScreen > onPressed ");
                // context.watch<HostController>().getHosts();
                hostController.getHosts();
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
                print("HostListScreen > onPressed ");
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HostAdd()));
              },
              icon: const Icon(Icons.add),
              label: const Text("추가"),
            ),
          ],
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: context.watch<HostController>().listHost.length,
            itemBuilder: (context, index) {
              return HostItem(context
                  .watch<HostController>()
                  .listHost[index]);
            }),
      ],
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return context.watch<HostController>().isLoading
  //       ? const CircularProgressIndicator()
  //       : Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: [
  //           ElevatedButton.icon(
  //             style: TextButton.styleFrom(
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: defaultPadding,
  //                 vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
  //               ),
  //             ),
  //             onPressed: () {
  //               print("HostListScreen > onPressed ");
  //               context.watch<HostController>().getHosts();
  //             },
  //             icon: const Icon(Icons.swap_horiz),
  //             label: const Text("새로고침"),
  //           ),
  //           const SizedBox(width: 10,),
  //           ElevatedButton.icon(
  //             style: TextButton.styleFrom(
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: defaultPadding,
  //                 vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
  //               ),
  //             ),
  //             onPressed: () {
  //               print("HostListScreen > onPressed ");
  //               Navigator.push(context, MaterialPageRoute(builder: (context) => const HostAdd()));
  //             },
  //             icon: const Icon(Icons.add),
  //             label: const Text("추가"),
  //           ),
  //         ],
  //       ),
  //       ListView.builder(
  //         physics: const NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         itemCount: context.watch<HostController>().listHost.length,
  //         itemBuilder: (context, index) {
  //           return HostItem(context
  //             .watch<HostController>()
  //             .listHost[index]);
  //         }),
  //     ],
  //   );
  // }
}
