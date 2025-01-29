import 'package:flutter/material.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  bool Income = true, Expense = false, Loan = false;
  String selectedCategory = "";

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
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                _showCategoryDialog();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  enabled: false, 
                  decoration: InputDecoration(
                    labelText: "Category",
                    labelStyle: TextStyle(
                        fontSize: 15, color: Colors.grey.shade700),
                  
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1)),
                  ),
                  controller: TextEditingController(
                      text: selectedCategory), 
                ),
              ),
            ),
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
void _showCategoryDialog() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Select Category",
          style: TextStyle(fontSize: 15, color: Colors.blue),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            height: 300, 
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 10, 
                mainAxisSpacing: 10, 
              ),
              itemCount: categories.length,
            
               
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index]['label'];
                    });
                    Navigator.of(context).pop(); // 
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          categories[index]['icon'],
                          size: 32,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        categories[index]['label'],
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}

}
