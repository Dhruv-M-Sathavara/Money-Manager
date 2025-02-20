import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:expance_manager/functions/database_conectivity.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool Income = true, Expense = false, Loan = false;

  TextEditingController amount = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController account = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController date = TextEditingController();

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

    final List<Map<String, dynamic>> categoriesIncome = [
    {"icon": Icons.card_giftcard, "label":"Allowance"},
    {"icon": Icons.attach_money, "label":"Salary"},
    {"icon": Icons.trending_up, "label":"Bonus"},
    {"icon": Icons.category, "label":"Other"},

  ];

  final List<Map<String, dynamic>> accounts = [
    {"icon": Icons.money, "label": "Cash"},
    {"icon": Icons.account_balance, "label": "Bank"},
    {"icon": Icons.credit_card, "label": "Card"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Add Transaction',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    categoryButton("Income", Income, Colors.green.shade300),
                    categoryButton("Expense", Expense, Colors.red.shade300),
                    categoryButton("Loan", Loan, Colors.blue.shade300),
                  ],
                ),
                SizedBox(height: 25),
                buildTextField("Date", date, true, prefixIcon: Icons.calendar_today, onTap: () => _selectDate(context)),
                SizedBox(height: 15),
                buildTextField("Amount", amount, false, prefixIcon: Icons.attach_money, keyboardType: TextInputType.number),
                SizedBox(height: 15),
                buildDropdownField("Select Category", category,Income ? categoriesIncome :categories, (String value) {
                  category.text = value;
                  setState(() {
                    selectedCategory = value;
                  });
                }),
                SizedBox(height: 15),
                buildDropdownField("Select Account", account, accounts, (String value) {
                  account.text = value;
                  setState(() {
                    selectedPaymentMethod = value;
                  });
                }),
                SizedBox(height: 15),
                buildTextField("Note", note, false, prefixIcon: Icons.note),
                SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    String id = randomAlphaNumeric(10);
                    Map<String, dynamic> money = {
                      "Amount": amount.text,
                      "Category": selectedCategory,
                      "Accounts": selectedPaymentMethod,
                      "Note": note.text,
                      "Date": date.text,
                      "Type": Income ? "Income" : Expense ? "Expense" : "Loan",
                      "id" : id,
                      
                    };

                    DBOP().addIncome(money, id);
                    Navigator.pop(context); 
                  },
                  child: Text("Save Transaction", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),),
        ),),
    );
  }

  // **Transaction Type Button**
  Widget categoryButton(String title, bool isSelected, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Income = (title == "Income");
          Expense = (title == "Expense");
          Loan = (title == "Loan");
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



  ///
  Widget buildTextField(String label, TextEditingController controller, bool readOnly, {IconData? prefixIcon, VoidCallback? onTap, TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.blueAccent) : null,
        labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade700),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.blueAccent)),
      ),
    );
  }


///dropdown
  Widget buildDropdownField(String hint, TextEditingController controller, List<Map<String, dynamic>> items, Function(String) onSelected) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(Icons.list, color: Colors.blueAccent),
          suffixIcon: PopupMenuButton<String>(
            icon: Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
            color: Colors.white, 
            onSelected: onSelected,
            itemBuilder: (BuildContext context) {
              return items.map((item) {
                return PopupMenuItem<String>(
                  value: item['label'],
                  child: Row(
                    children: [
                      Icon(item['icon'], size: 20, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(item['label']),
                    ],
                  ),
                );
              }).toList();
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),);
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
    if (picked != null) setState(() => date.text = "${picked.day}-${picked.month}-${picked.year}");
  }
}
