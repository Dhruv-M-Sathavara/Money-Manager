import 'package:expance_manager/functions/database_conectivity.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  TextEditingController amount = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController rate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Data"),),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 20,),
            buildTextField("Amount", amount, false,keyboardType: TextInputType.numberWithOptions()),
            SizedBox(height: 15,),
            buildTextField("Rate in %", rate, false,keyboardType: TextInputType.numberWithOptions()),
            SizedBox(height: 15,),
            buildTextField("Year", time, false,keyboardType: TextInputType.numberWithOptions()),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                String id = randomAlphaNumeric(10);
                Map<String, dynamic> loan ={
                    "Amount" : amount.text,
                    "Rate" : rate.text,
                    "Year" : time.text,
                    "id" : id
                }; 
                DBOP().loan(loan, id);
                Navigator.pop(context);
              },
              
              child: Container(
                width: 500,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Save" , style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
              ),
            )
            
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, bool readOnly, {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
   
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
       
        labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade700),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.blueAccent)),
      ),
    );
  }
}