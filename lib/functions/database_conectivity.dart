
import 'package:cloud_firestore/cloud_firestore.dart';

class DBOP{
  Future addIncome(Map<String,dynamic> money, String id) async{
    return await FirebaseFirestore.instance.collection("Income").doc(id).set(money);
  }
  Future addExpance(Map<String,dynamic> money, String id) async{
    return await FirebaseFirestore.instance.collection("Expance").doc(id).set(money);
  }
  
}