
import 'package:cloud_firestore/cloud_firestore.dart';

class DBOP{
  Future addIncome(Map<String,dynamic> money, String id) async{
    return await FirebaseFirestore.instance.collection("transaction").doc(id).set(money);
  }
  

  Stream<QuerySnapshot> getMoney(String back) {
  return FirebaseFirestore.instance.collection(back).snapshots();
}

  
}