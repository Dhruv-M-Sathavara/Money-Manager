import 'package:flutter/material.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  bool Income = true,Expense = false , Loan = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        title: const Text('Task Name',style: TextStyle(fontSize: 18),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: [
                categorybutton("Income",Income, Colors.green.shade300),
                categorybutton("Expense",Expense, Colors.red.shade300),
                categorybutton("Loan", Loan, Colors.blue.shade300)
              ],
            ),
            SizedBox(height: 25,),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(decoration: InputDecoration(
                labelText: "Date",
                labelStyle: TextStyle(fontSize: 15,color: Colors.grey.shade700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide( width: 1)
                )
              ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(decoration: InputDecoration(
                labelText: "Amount",
                labelStyle: TextStyle(fontSize: 15,color: Colors.grey.shade700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1)
                )
              ),),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: GestureDetector(
                onTap: (){
                  
                  
                },
                child: TextField(decoration: InputDecoration(
                  labelText: "Category",
                  labelStyle: TextStyle(fontSize: 15, color:Colors.grey.shade700),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1)
                  )
                ),),
              ),
            )
          ],
        ),
      )
    );
  }
  
Widget categorybutton(String title,bool isSelected,Color color ){
    return GestureDetector(
      onTap: (){
        if(title == "Income"){
          Income = true;
          Expense = false;
          Loan = false;
          
        }
        if(title == "Expense"){
          Income = false;
          Expense = true;
          Loan = false;
        }
        if(title == "Loan"){
          Income = false;
          Expense = false;
          Loan = true;
        }
        setState(() {
          
        });
      },
      child: Material(
        elevation: isSelected ? 5 : 0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
}

}