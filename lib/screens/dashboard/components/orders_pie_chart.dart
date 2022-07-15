import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/shared/constants.dart';

class OrdersPieChart extends StatelessWidget {
  OrdersPieChart();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: secondaryColor,
        ),
        child: Container(),
        // child: SfCircularChart(
        //     title: ChartTitle(text: 'Orders Status'),
        //     legend: Legend(isVisible: true),
        //     // tooltipBehavior:
        //     //     TooltipBehavior(enable: true, format: 'point.x : point.y%'),
        //     series: <CircularSeries>[
        //       // Render pie chart
        //       PieSeries<OrderInfo, String>(
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
        //           dataSource: context.read<OrdersController>().chartData,
        //           pointColorMapper: (OrderInfo data, _) => data.color,
        //           dataLabelMapper: (OrderInfo data, _) =>
        //           data.title.toString() +
        //               "\n" +
        //               data.percentage.toString() +
        //               "%",
        //           xValueMapper: (OrderInfo data, _) => data.title,
        //           yValueMapper: (OrderInfo data, _) => data.percentage)
        //     ])
    );
  }
}
