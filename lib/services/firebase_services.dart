import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseServices{
  void fireBaseStore(String name ,String password)async{
    var db= FirebaseFirestore.instance.collection("test1");
    db.add({"name":name,"password":password}).then((value) {
      print(value.path);
    });

  }
}