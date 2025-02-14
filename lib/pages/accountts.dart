import 'package:expance_manager/functions/database_conectivity.dart';
import 'package:flutter/material.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  Stream? accounts;

  double totalCash = 0, remainingCash = 0, spentCash = 0;
  double totalBank = 0, remainingBank = 0, spentBank = 0;
  double totalCard = 0, remainingCard = 0, spentCard = 0;

  @override
  void initState() {
    super.initState();
    money();
  }

  void money() async {
    accounts = DBOP().getMoney('transaction');

    accounts!.listen((snapshot) {
      double cashIncome = 0, cashExpense = 0;
      double bankIncome = 0, bankExpense = 0;
      double cardIncome = 0, cardExpense = 0;

      for (var doc in snapshot.docs) {
        String account = doc['Accounts'] ?? 'others';
        double money = double.tryParse(doc['Amount'] ?? '0') ?? 0;
        String type = doc['Type'] ?? '';

        if (account == 'Cash') {
          if (type == 'Income') {
            cashIncome += money;
          } else if (type == 'Expense') {
            cashExpense += money;
          }
        } else if (account == 'Bank') {
          if (type == 'Income') {
            bankIncome += money;
          } else if (type == 'Expense') {
            bankExpense += money;
          }
        } else if (account == 'Card') {
          if (type == 'Income') {
            cardIncome += money;
          } else if (type == 'Expense') {
            cardExpense += money;
          }
        }
      }

      setState(() {
        totalCash = cashIncome;

        remainingCash = cashIncome - cashExpense;

        spentCash = cashExpense;

        totalBank = bankIncome;
        remainingBank = bankIncome - bankExpense;
        spentBank = bankExpense;

        totalCard = cardIncome;
        remainingCard = cardIncome - cardExpense;
        spentCard = cardExpense;
      });
    });
  }

  Widget OpAccounts() {
    return StreamBuilder(
        stream: accounts,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              accountCard("Cash", Icons.money, totalCash, remainingCash, spentCash),
              accountCard("Bank", Icons.account_balance, totalBank, remainingBank, spentBank),
              accountCard("Card", Icons.credit_card, totalCard, remainingCard, spentCard),
            ],
          );
        }); }

  Widget accountCard(String title, IconData icon, double total, double remaining, double spent) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 130,
        width: double.infinity,
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
          ],  ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.greenAccent.shade200,
              child: Icon(icon),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                labels("Total: ", total, Colors.blue.shade600),
                labels("Remaining: ", remaining, Colors.green.shade600),
                labels("Spent: ", spent, Colors.red.shade600),
              ],
            ),
          ],
        ),),
    ); }

  Widget labels(String label, double amount, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: color, fontSize: 16)),
        SizedBox(width: 5),
        Text("₹${amount.toStringAsFixed(2)}",
            style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Accounts"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: OpAccounts(),
      ),
    );
  }
}
