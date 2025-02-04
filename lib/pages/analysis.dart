import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {

  final List<SalesData> chartData = [
    SalesData(2001, 34000, Colors.red),
    SalesData(2002, 36000, Colors.blue),
    SalesData(2003, 37000, Colors.yellow),
    SalesData(2004, 31000, Colors.green),
    SalesData(2005, 20000, Colors.orange),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Container( 
          height: 300,
          margin: EdgeInsets.all(10),
          child: SfCartesianChart(
            legend: Legend(isVisible: true),
            title: ChartTitle(text: 'Sales Data'),
            series: [
              ColumnSeries<SalesData, int>(
                pointColorMapper: (SalesData sales, _) => sales.color,
                legendItemText: 'Sales',
                dataSource: chartData,  xValueMapper: (SalesData sales, _)=> sales.year, 
                yValueMapper: (SalesData sales, _) => sales.sales
                )
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  final int year;
  final double sales;
  final Color color;

  SalesData(this.year, this.sales, this.color);
}