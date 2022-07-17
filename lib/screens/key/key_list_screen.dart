import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/key_controller.dart';
import '../../shared/constants.dart';
import '../../shared/responsive.dart';
import 'components/key_item.dart';

class KeyListScreen extends StatelessWidget {
  const KeyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<KeyController>().isLoading
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
                print("KeyListScreen > onPressed ");
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New"),
            ),
          ],
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: context.watch<KeyController>().listKmsKeys.length,
            itemBuilder: (context, index) {
              return KeyItem(context
                  .watch<KeyController>()
                  .listKmsKeys[index]);
            }),
      ],
    );
  }
}
