import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expance_manager/functions/database_conectivity.dart';
import 'package:expance_manager/pages/split.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {

  Future<void> backupdata() async{
    final pdf = pw.Document();

    QuerySnapshot snapshot  = await FirebaseFirestore.instance.collection('transaction').get();

    pdf.addPage(
      pw.Page(build: (pw.Context context){
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Trasaction History",style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold,)),
            pw.SizedBox(height: 10),
            for(var doc in snapshot.docs)
              pw.Text(" => Date: ${doc['Date']} - Type:  ${doc['Type']} - Note: ${doc['Note']} - Category: ${doc['Category']} - Amount: ${doc['Amount']}  - Accounts: ${doc['Accounts']}" ),
            
          ]
        );
      })
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format)async => pdf.save());
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
                Column(
                  children: [
                    IconButton(icon: Icon( Icons.backup), color: Colors.blue.shade300, onPressed: () { backupdata(); },),
                    Text("Backup")
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      color: Colors.red.shade300,
                      onPressed: () async {
                        bool confirmDelete = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Delete All Transactions"),
                              content: Text("Are you sure you want to delete all transaction history?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false), 
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true), 
                                  child: Text("Delete", style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            );
                          },
                        ) ?? false;

                        if (confirmDelete) {
                          await DBOP().deleteAll();
                          setState(() {}); 
                        }
                      },
                      icon: Icon(Icons.delete),
                    ),
                    Text("Delete History"),
                  ],
                ),
                Column(
                  children: [
                    IconButton(icon: Icon(Icons.people), color: Colors.green.shade300, onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Slitop()));
                    },),
                    Text("Split")
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
