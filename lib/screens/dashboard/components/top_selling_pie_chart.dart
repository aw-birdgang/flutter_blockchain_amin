import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/shared/constants.dart';

class TopSellingPieChart extends StatelessWidget {
  const TopSellingPieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: secondaryColor,
        ),
        child: Container(),
        // child: SfCircularChart(
        //     title: ChartTitle(text: 'Top 5 Selling Products'),
        //     legend: Legend(isVisible: true),
        //     series: <CircularSeries>[
        //       // Renders radial bar chart
        //       PieSeries<TopSellingModel, String>(
        //           explode: true,
        //           explodeIndex: 1,
        //           radius: '55%',
        //           dataLabelSettings: DataLabelSettings(
        //               isVisible: true,
        //               labelIntersectAction: LabelIntersectAction.shift,
        //               overflowMode: OverflowMode.shift,
        //               showZeroValue: true,
        //               labelPosition: ChartDataLabelPosition.inside,
        //               connectorLineSettings:
        //               ConnectorLineSettings(type: ConnectorType.curve)),
        //           dataSource:
        //           context.read<OrdersController>().list_of_top_selling,
        //           pointColorMapper: (TopSellingModel data, _) => data.color,
        //           dataLabelMapper: (TopSellingModel data, _) =>
        //               data.nb.toString(),
        //           xValueMapper: (TopSellingModel data, _) => data.name,
        //           yValueMapper: (TopSellingModel data, _) => data.nb)
        //     ])
    );
  }
}
