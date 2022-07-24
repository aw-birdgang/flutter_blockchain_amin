import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/kmskey_controller.dart';
import '../../shared/constants.dart';
import '../../shared/responsive.dart';
import 'components/kmsKey_add.dart';
import 'components/kmsKey_item.dart';

class KmsKeyListScreen extends StatefulWidget {
  const KmsKeyListScreen({Key? key}) : super(key: key);
  @override
  State<KmsKeyListScreen> createState() => _KmsKeyListScreenState();
}

class _KmsKeyListScreenState extends State<KmsKeyListScreen> {
  late KmsKeyController kmsKeyController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => KmsKeyController()..getKmsKeys(),
      child: _consumer(context),
    );
  }

  Widget _consumer(BuildContext context) {
    return Consumer<KmsKeyController>(
      builder: (context, kmsKeyController, child) {
        this.kmsKeyController = kmsKeyController;
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
    return context.watch<KmsKeyController>().isLoading
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
                // context.watch<HostController>().getClients();
                kmsKeyController.getKmsKeys();
              },
              icon: const Icon(Icons.swap_horiz),
              label: const Text("새로 고침"),
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
                print("KeyListScreen > onPressed ");
                Navigator.push(context, MaterialPageRoute(builder: (context) => const KmsKeyAdd()));
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New"),
            ),
          ],
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: context.watch<KmsKeyController>().listKmsKeys.length,
          itemBuilder: (context, index) {
            return KmsKeyItem(context
              .watch<KmsKeyController>()
              .listKmsKeys[index]);
          }),
      ],
    );
  }
}
