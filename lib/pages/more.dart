import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expance_manager/functions/database_conectivity.dart';
import 'package:expance_manager/pages/vyaj.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:math';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  Stream? hello;

  Future<void> backupdata() async {
    final pdf = pw.Document();

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('transaction').get();

    pdf.addPage(
      pw.Page(build: (pw.Context context) {
        return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Transaction History",
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  )),
              pw.SizedBox(height: 10),
              for (var doc in snapshot.docs)
                pw.Text(
                    " => Date: ${doc['Date']} - Type:  ${doc['Type']} - Note: ${doc['Note']} - Category: ${doc['Category']} - Amount: ${doc['Amount']}  - Accounts: ${doc['Accounts']}"),
            ]);
      }),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    hello = DBOP().getdata("Loan");
    setState(() {});
  }

  Widget getop() {
    return StreamBuilder(
        stream: hello,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot docsnap = snapshot.data.docs[index];

                    double principal =
                        double.tryParse(docsnap['Amount'].toString()) ?? 0;
                    double rate =
                        double.tryParse(docsnap['Rate'].toString()) ?? 0;
                    double time =
                        double.tryParse(docsnap['Year'].toString()) ?? 0;

                    double simpleInterest = (principal * rate * time) / 100;
                    double compoundInterest =
                        principal * (pow((1 + rate / 100), time)) - principal;

                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Amount: ₹${docsnap['Amount']}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Rate: ${docsnap['Rate']}%",
                                    style: TextStyle(fontSize: 16)),
                                Text("Years: ${docsnap['Year']}",
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            Divider(),
                            Text(
                              "Simple Interest: ₹${simpleInterest.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Compound Interest: ₹${compoundInterest.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton(Icons.backup, "Backup", Colors.blue.shade300, () {
                  backupdata();
                }),
                _actionButton(Icons.delete, "Delete History", Colors.red.shade300,
                    () async {
                  bool confirmDelete = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Delete All Transactions"),
                            content: Text(
                                "Are you sure you want to delete all transaction history?"),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text("Delete",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          );
                        },
                      ) ??
                      false;

                  if (confirmDelete) {
                    await DBOP().deleteAll();
                    setState(() {});
                  }
                }),
                _actionButton(Icons.people, "Interest", Colors.blue.shade300,
                    () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => MyWidget()));
                }),
              ],
            ),
            SizedBox(height: 30),
            Center(
                child: Text(
              "Interest Data",
              style: TextStyle(
                  color: Colors.green.shade300,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(height: 10),
            getop()
          ],),
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, Color color, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          color: color,
          onPressed: onPressed,
        ),
        Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );}
}
