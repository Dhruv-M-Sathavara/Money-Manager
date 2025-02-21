import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expance_manager/functions/database_conectivity.dart';
import 'package:expance_manager/pages/addsplits.dart';
import 'package:flutter/material.dart';


class Slitop extends StatefulWidget {
  const Slitop({super.key});

  @override
  State<Slitop> createState() => _SplitState();
}

class _SplitState extends State<Slitop> {

  Stream? splitOp;

  double perperson = 0;
  double totalremaining = 0;
  double totalexpance = 0; 

  @override
  void initState() {
    
    super.initState();
  
  }

  loadop() async{
    splitOp = DBOP().getSplit('Splitting Data');
    splitOp!.listen((snapshot){
      double balance = 0;
      double remaining = 0;
      double expance = 0;
      double single = 0;
      double pps = 0;

      for(var doc in snapshot.docs){
        double Total = double.tryParse(doc['Per Person Amount']??'0')?? 0;
        if(doc['Type'] == "Income"){
            single += Total*pps;
        }
        else if (doc['Type'] == 'Expense') {
          expance += Total;
        }

        balance = single - expance;

        setState(() {
          totalremaining = balance;
          totalexpance = expance;
        });
      }
    });
  }

  Widget getWork(){
    return StreamBuilder(stream: splitOp, builder: (context,AsyncSnapshot snapshot){
      if(!snapshot.hasData){
        return Center(child: CircularProgressIndicator());
      }
      return Expanded(child: ListView.builder(itemCount: snapshot.data.docs.length,itemBuilder: (context,index){
        DocumentSnapshot docsnap = snapshot.data.docs[index];
        return Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: docsnap['Type'] == 'Income' ? Colors.green.shade100 : Colors.red.shade100,
                        child: Icon(docsnap['Type'] == 'Income' ? Icons.arrow_upward : Icons.arrow_downward),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            docsnap['Member'],
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            docsnap['Note'],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            docsnap['Category'],
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Column(children: [
                    Text(
                    '₹${docsnap['Per Person Amount'] ?? '0'}',
                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:  docsnap['Type'] == 'Income' ? Colors.green : Colors.red),
                  ),
                  Text(
                    docsnap['Type'],
                    style: TextStyle(color:  docsnap['Type'] == 'Income' ? Colors.green : Colors.red),
                  ),
                  ],)
                  
                
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
      appBar: AppBar(title: Text("Split Calculator"),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10), 
          child: Column(children: [
                  Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          dataContainer("Total Income",totalexpance, Colors.green.shade100, Colors.green),
                          dataContainer("Single People", totalremaining, Colors.green.shade100, Colors.green),
                        ],
                      ),
                        SizedBox(height: 10,),
                      Row(
                        children: [
                          dataContainer("Remainig", 200, Colors.green.shade100, Colors.green),
                          dataContainer("Expense", 1200, Colors.red.shade100, Colors.red),
                        ],
                      ),
                      getWork()
                    ],
                  ),
           ] )
          ),
        ),floatingActionButton: FloatingActionButton(
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Splidata()));},backgroundColor: Colors.green.shade300,
        child: Icon(Icons.add, color: Colors.white, size: 30),),
    );
    
  }


  Widget dataContainer(String text, double amount, Color color, Color textColor){
    return Expanded(child: Container(
      margin: EdgeInsets.only(left:4),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
      
       child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text , style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('₹${amount}', style: TextStyle(fontSize: 18)),
            ],
          ),
     ),
    );
  }

  
}