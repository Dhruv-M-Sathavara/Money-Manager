import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  List<Piechart> expenseData = [];
  List<Piechart> incomeData = [];

  @override
  void initState() {
    super.initState();
    fetchChartData();
  }

  void fetchChartData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('transaction').get();
    Map<String, double> expenseMap = {};
    Map<String, double> incomeMap = {};
    
    for (var doc in snapshot.docs) {
      String category = doc['Category'] ?? 'Other';
      double amount = double.tryParse(doc['Amount'] ?? '0') ?? 0.0;
      
      if (doc['Type'] == 'Expense') {
        expenseMap[category] = (expenseMap[category] ?? 0) + amount;
      } else if (doc['Type'] == 'Income') {
        incomeMap[category] = (incomeMap[category] ?? 0) + amount;
      }
    }

    setState(() {
      expenseData = expenseMap.entries.map((e) => Piechart(e.value, e.key)).toList();
      incomeData = incomeMap.entries.map((e) => Piechart(e.value, e.key)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analysis"),
        
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: expenseData.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : SfCircularChart(
                        title: ChartTitle(text: 'Expenses', textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        legend: Legend(isVisible: true, position: LegendPosition.bottom),
                        palette: [Colors.red.shade400, Colors.blue.shade400, Colors.orange.shade400, Colors.green.shade400],
                        series: [
                          PieSeries<Piechart, String>(
                            explode: true,
                            radius: '100',
                            dataSource: expenseData,
                            xValueMapper: (Piechart data, _) => data.category,
                            yValueMapper: (Piechart data, _) => data.amount,
                            dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: incomeData.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : SfCircularChart(
                        title: ChartTitle(text: 'Income', textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        legend: Legend(isVisible: true, position: LegendPosition.bottom),
                        palette: [Colors.green.shade400, Colors.blue.shade400, Colors.purple.shade400, Colors.yellow.shade400],
                        series: [
                          PieSeries<Piechart, String>(
                            explode: true,
                            radius: '100',
                            dataSource: incomeData,
                            xValueMapper: (Piechart data, _) => data.category,
                            yValueMapper: (Piechart data, _) => data.amount,
                            dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade100,
    );
  }
}

class Piechart {
  final double amount;
  final String category;

  Piechart(this.amount, this.category);
}