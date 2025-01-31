import 'package:expance_manager/functions/database_conectivity.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  bool Income = true, Expense = false, Loan = false;

  TextEditingController amount = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController account = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController date = TextEditingController();

  String? selectedCategory;
  String? selectedPaymentMethod;
  String? selecteddata;

  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.fastfood, "label": "Food"},
    {"icon": Icons.people, "label": "Social Life"},
    {"icon": Icons.pets, "label": "Pets"},
    {"icon": Icons.directions_car, "label": "Transport"},
    {"icon": Icons.image, "label": "Culture"},
    {"icon": Icons.chair, "label": "Household"},
    {"icon": Icons.checkroom, "label": "Apparel"},
    {"icon": Icons.brush, "label": "Beauty"},
    {"icon": Icons.health_and_safety, "label": "Health"},
    {"icon": Icons.book, "label": "Education"},
    {"icon": Icons.card_giftcard, "label": "Gift"},
    {"icon": Icons.category, "label": "Other"},
  ];

    final List <Map<String, dynamic>> accounts = [
      {"icon":Icons.money, "label" : "Cash"},
      {"icon":Icons.account_balance, "label":"Accounts"},
      {"icon":Icons.credit_card ,"label":"Card"}
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Task Name',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    categorybutton("Income", Income, Colors.green.shade300),
                    categorybutton("Expense", Expense, Colors.red.shade300),
                    categorybutton("Loan", Loan, Colors.blue.shade300),
                  ],
                ),
                SizedBox(height: 25),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: date,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      labelText: "Date",
                      labelStyle:
                          TextStyle(fontSize: 15, color: Colors.grey.shade700),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
              SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: amount,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      labelText: "Amount",
                      labelStyle:
                          TextStyle(fontSize: 15, color: Colors.grey.shade700),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
              
                SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: category,
                      decoration: InputDecoration(
                        hintText: "Select Category",
                        suffixIcon: PopupMenuButton<String>(
                          color: Colors.white,
                          icon: Icon(Icons.arrow_drop_down), 
                          onSelected: (String value) {
                            category.text = value; 
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return categories.map((category) {
                              return PopupMenuItem<String>(
                                value: category['label'],
                                child: Row(
                                  children: [
                                    Icon(category['icon'], size: 20, color: Colors.blue),
                                    SizedBox(width: 10),
                                    Text(category['label']),
                                  ],
                                ),
                              );
                            }).toList();
                          },
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),

                SizedBox(height: 15,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: TextFormField(
                    controller: account,
                    decoration: InputDecoration(
                      hintText: "Select Account",
                      suffixIcon: PopupMenuButton<String>(
                        icon: Icon(Icons.arrow_drop_down),
                        color: Colors.white, 
                        onSelected: (String value) {
                          account.text = value;
                          setState(() {
                            selectedPaymentMethod = value;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return accounts.map((account) {
                            return PopupMenuItem<String>(
                              value: account['label'],
                              child: Row(
                                children: [
                                  Icon(account['icon'], size: 20, color: Colors.blue),
                                  SizedBox(width: 10),
                                  Text(account['label']),
                                ],
                              ),
                            );
                          }).toList();
                        },
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),

                SizedBox(height:15 ,),
               Container(
                padding: EdgeInsets.symmetric(horizontal:20),
                child: TextField(
                  controller: note,
                   decoration: InputDecoration(
                      labelText: "Note",
                      labelStyle: TextStyle(color: Colors.grey.shade700,fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1)
                      )   
                   )
                ),
               ),
                SizedBox(height: 25,),     
                ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue.shade200,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  minimumSize: Size(100, 40)
                ), onPressed: (){
                  String id = randomAlphaNumeric(10);
                  Map<String,dynamic> money = {
                    "Income Amount" : amount.text,
                    "Category" : selectedCategory,
                    "Accounts" : selectedPaymentMethod,
                    "Note" : note.text,
                    "Date" : date.text
                  };

                  if(Expense){
                   DBOP().addExpance(money, id); 
                  }
                  if(Income){
                    DBOP().addIncome(money, id);
                  }
                }, child: Text("Save", style: TextStyle(fontSize: 15 , color: Colors.white),))    
                ]
            ),
              ),
        ),
      ));
  }

  Widget categorybutton(String title, bool isSelected, Color color) {
    return GestureDetector(
      onTap: () {
        if (title == "Income") {
          Income = true;
          Expense = false;
          Loan = false;
        }
        if (title == "Expense") {
          Income = false;
          Expense = true;
          Loan = false;
        }
        if (title == "Loan") {
          Income = false;
          Expense = false;
          Loan = true;
        }
        setState(() {});
      },
      child: Material(
        elevation: isSelected ? 5 : 0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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

    Future<void> _selectDate(BuildContext context) async {
      final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        date.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

}
