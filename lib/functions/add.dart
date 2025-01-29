import 'package:flutter/material.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  bool Income = true, Expense = false, Loan = false;

  String? selectedCategory;
  String? selectedPaymentMethod;

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
      body: Container(
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
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Date",
                  labelStyle:
                      TextStyle(fontSize: 15, color: Colors.grey.shade700),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1)),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                  labelStyle:
                      TextStyle(fontSize: 15, color: Colors.grey.shade700),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1)),
                ),
              ),
            ),
          
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(padding: EdgeInsets.symmetric(horizontal: 4), dropdownColor: Colors.white,
                  hint:  Text('Select Category',style: TextStyle(fontSize: 15),),
                  value: selectedCategory,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category['label'],
                      child: Row(
                        children: [
                          Icon(category['icon'], size: 20, color: Colors.blue),
                          SizedBox(width: 10),
                          Text(category['label']),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey,width: 1)
              ),
              child: DropdownButtonHideUnderline(child: DropdownButton(padding: EdgeInsets.symmetric(horizontal: 4), dropdownColor: Colors.white, hint: Text("Selected Account",style:TextStyle(fontSize:15),), value: selectedPaymentMethod, onChanged: (String? newMethod){
                setState(() {
                  selectedPaymentMethod = newMethod!;
                });
              },
              items: accounts.map((accounts){
                  return DropdownMenuItem<String>(
                    value: accounts['label'],
                    child: Row(
                    
                    children: [
                      
                    Icon(accounts['icon'], size: 20, color: Colors.blue),
                    SizedBox(width: 10),
                      
                    Text(accounts['label'])],
                  ));
              }).toList(),
              )),
            )
          ],
        ),
      ),

    );
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
}
