import 'package:expance_manager/pages/accountts.dart';
import 'package:expance_manager/pages/analysis.dart';
import 'package:expance_manager/pages/home_page.dart';
import 'package:expance_manager/pages/more.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}


class _NavigationState extends State<Navigation> {


int selectedIndex = 0;
PageController pageController = PageController();


void onTap (int index){
  setState(() {
    selectedIndex = index;
  });
  pageController.jumpToPage(index);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: pageController,physics:NeverScrollableScrollPhysics(),children: [
        HomePage(),
        Analysis(),
        Accounts(),
        More()
      ],),
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.list_alt),label: "Tras."),
        BottomNavigationBarItem(icon: Icon(Icons.pie_chart),label: "Analysis"),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet),label: "Badget"),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz),label: "More")

      ],currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: onTap,),
    );

  }
}