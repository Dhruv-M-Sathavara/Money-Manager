import 'package:expance_manager/functions/database_conectivity.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Splidata extends StatefulWidget {
  const Splidata({super.key});

  @override
  State<Splidata> createState() => _SplidataState();
}

class _SplidataState extends State<Splidata> {
  bool Income = true, Expence = false;

  TextEditingController Amount = TextEditingController();
  TextEditingController TotalPeople = TextEditingController();
  TextEditingController Note = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Data"),),
      body:  SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
        
        
          child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    categoryButton("Income", Income, Colors.green.shade300),
                    categoryButton("Expense", Expence, Colors.red.shade300),
                  ],
                ),
                SizedBox(height: 25),
            
            textfield(Income ? "Enter Per Person Amount" : "Amount", Amount,false,keyboardType: TextInputType.numberWithOptions() ,),
            SizedBox(height: 20,),
            Income ? textfield("Total member", TotalPeople, false, keyboardType: TextInputType.numberWithOptions()) : Container(),
            SizedBox(height: 20,),
            textfield("Note", Note, false),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: () {
                String id = randomAlphaNumeric(10);
                Map<String , dynamic> money = {
                  Income ? "Per Person Amount" :"Expance Amount"  : Amount.text ,
                  "Note" : Note.text,
                  "Member" : TotalPeople.text,
                  "Type" : Income ? "Income" : "Expance",
                };

                DBOP().addsplit(money, id);
                Navigator.pop(context);
              },
              child: Container(
              
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue.shade300,
              ),
              child: Center(child: Text("Save",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white),)),
              ),
            )
          ],),
        ),
      ),
    );
  }
    Widget textfield (String hint, TextEditingController controller, bool readOnly ,{TextInputType? keyboardType}){
    return TextField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: hint,
      labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade700),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.blueAccent)),)
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

    Widget categoryButton(String title, bool isSelected, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Income = (title == "Income");
          Expence = (title == "Expense");
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
          boxShadow: isSelected ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 5)] : [],
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black54),
        ),
      ),
    );
  }
}