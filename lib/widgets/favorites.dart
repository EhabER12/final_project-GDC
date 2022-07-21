import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ehab/resourses/color_manager.dart';
import 'package:final_project_ehab/resourses/styles_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget fetchData (String collectionName){
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("favorites")
        .snapshots(),
    builder:
        (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Center(
          child: Text("Something is wrong"),
        );
      }

      return ListView.builder(
          itemCount:
          snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot _documentSnapshot =
            snapshot.data!.docs[index];

            return Card(
              color: ColorManager.primary,
              elevation: 5,
              child: ListTile(

                leading:Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(_documentSnapshot['image']))
                  ),
                ),

title: Text(_documentSnapshot['name'],style: getBoldStyle(color: ColorManager.white)),
                trailing: GestureDetector(

                  child: const CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Icon(Icons.remove_circle,color:Colors.white,),
                  ),
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection(collectionName)
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection("favorites")
                        .doc(_documentSnapshot.id)
                        .delete();
                  },
                ),
              ),
            );
          });
    },
  );
}