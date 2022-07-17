import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/shared/responsive.dart';

import '../../shared/constants.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const SizedBox(height: defaultPadding),
                  !Responsive.isMobile(context) ? Row(
                    children: const [
                      SizedBox(width: defaultPadding),
                    ],
                  ) : Column(
                    children: const [
                      SizedBox(
                        height: defaultPadding,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!Responsive.isMobile(context))
              const SizedBox(width: defaultPadding),
          ],
        )
      ],
    );
  }
}
