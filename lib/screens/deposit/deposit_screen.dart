import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/client_controller.dart';
import '../../shared/constants.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({Key? key}) : super(key: key);
  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  late ClientController clientController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClientController()..getClients(),
      child: _consumer(context),
    );
  }

  Widget _consumer(BuildContext context) {
    return Consumer<ClientController>(
      builder: (context, clientController, child) {
        this.clientController = clientController;
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
    return context.watch<ClientController>().isLoading
        ? const CircularProgressIndicator()
        : Column(
      children: [
        Container(),
      ],
    );
  }
}
