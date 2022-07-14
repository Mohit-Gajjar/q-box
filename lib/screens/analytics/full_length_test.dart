import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FullLengthTest extends StatefulWidget {
  const FullLengthTest({Key? key}) : super(key: key);

  @override
  State<FullLengthTest> createState() => _FullLengthTestState();
}

class _FullLengthTestState extends State<FullLengthTest> {
  late List<SalesData> _chartData;

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Full Lenght Test',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 5,
            shadowColor: Colors.yellowAccent,
          ),
          body: SfCartesianChart(
            title: ChartTitle(
              text: 'Test analysis',
              textStyle: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            legend: Legend(isVisible: true),
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              LineSeries<SalesData, double>(
                  name: 'Day of the Week',
                  dataSource: _chartData,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  enableTooltip: true)
            ],
            primaryXAxis: NumericAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            primaryYAxis: NumericAxis(
              labelFormat: '{value}',
            ),
          )),
    );
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(0, 0),
      SalesData(1, 25),
      SalesData(2, 17),
      SalesData(3, 36),
      SalesData(4, 73),
      SalesData(5, 51),
      SalesData(6, 70),
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
