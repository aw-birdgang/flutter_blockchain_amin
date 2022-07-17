import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/host_controller.dart';
import '../../shared/constants.dart';
import '../../shared/responsive.dart';
import 'components/host_item.dart';

class HostListScreen extends StatelessWidget {
  const HostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New"),
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
}
