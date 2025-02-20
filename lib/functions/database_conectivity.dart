
import 'package:cloud_firestore/cloud_firestore.dart';

class DBOP{
  Future addIncome(Map<String,dynamic> money, String id) async{
    return await FirebaseFirestore.instance.collection("transaction").doc(id).set(money);
  }
  

  Stream<QuerySnapshot> getMoney(String back) {
  return FirebaseFirestore.instance.collection(back).orderBy('Date', descending: true).snapshots();
  }

  Future<void> deleteAll() async {
      var collection = FirebaseFirestore.instance.collection("transaction");
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
  }

  
}