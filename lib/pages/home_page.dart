import 'package:expance_manager/functions/database_conectivity.dart';
import 'package:expance_manager/pages/add.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  Stream? moneyop;
  double totalBalance = 0.0;
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  int selectedIndex = 0;

  PageController pageController = PageController();

    void onTapped(int index){
    setState(() {
      selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    moneyop = DBOP().getMoney('transaction');
    moneyop!.listen((snapshot) {
      double balance = 0.0;
      double income = 0.0;
      double expense = 0.0;
      
      for (var doc in snapshot.docs) {
        double amount = double.tryParse(doc['Amount'] ?? '0') ?? 0.0;
        if (doc['Type'] == 'Income') {
          income += amount;
        } else if (doc['Type'] == 'Expense') {
          expense += amount;
        }
      }
      balance = income - expense;

      setState(() {
        totalBalance = balance;
        totalIncome = income;
        totalExpense = expense;
      });
    });
  }

  Widget getWork() {
    return StreamBuilder(
      stream: moneyop,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot docsnap = snapshot.data.docs[index];
                  return  Padding(
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
                            docsnap['Date'],
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
                    '₹${docsnap['Amount'] ?? '0'}',
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
              
              // Card(
              //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              //   child: ListTile(
              //     leading: CircleAvatar(
              //       backgroundColor: docsnap['Type'] == 'Income' ? Colors.green.shade100 : Colors.red.shade100,
              //       child: Icon(
              //         docsnap['Type'] == 'Income' ? Icons.arrow_upward : Icons.arrow_downward,
              //         color: docsnap['Type'] == 'Income' ? Colors.green : Colors.red,
              //       ),
              //     ),
              //     title: Text(docsnap['Category'] ?? 'No Category', style: TextStyle(fontWeight: FontWeight.bold)),
              //     subtitle: Text(docsnap['Date'] ?? 'No Date', style: TextStyle(color: Colors.grey)),
              //     trailing: Text(
              //       '₹${docsnap['Amount'] ?? '0'}',
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         color: docsnap['Type'] == 'Income' ? Colors.green : Colors.red,
              //       ),
              //     ),
              //   ),
              // );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding:EdgeInsets.symmetric(vertical: 23)),
           Row(
              children: [
                Padding(padding:EdgeInsets.symmetric(horizontal: 10) ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.person, size: 30, color: Colors.white),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'ExtremeOp07',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          
          SizedBox(height: 15),
          
          
            Container(
                padding: EdgeInsets.symmetric(horizontal: 9),
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Text('Total Balance', style: TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('₹${totalBalance.toStringAsFixed(2)}', style: TextStyle(fontSize: 32)),
                    SizedBox(height: 15),
                    Row(
                    
                      children: [
                        dataContainer("Income", totalIncome, Colors.green.shade100, Colors.green),
                        dataContainer("Expense", totalExpense, Colors.red.shade100, Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
          
          getWork(),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          ).then((_) {
            load();
          });
        },
        backgroundColor: Colors.green.shade300,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Widget dataContainer(String title, double amount, Color bgColor, Color textColor) {
    return Expanded(
      child: Container( 
        margin: EdgeInsets.only(left:4),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
      
       child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon(title == "Income" ?Icons.arrow_upward : Icons.arrow_downward),
              Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('₹${amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      );

  

  }


}