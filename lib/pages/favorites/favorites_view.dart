import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ehab/resourses/color_manager.dart';
import 'package:final_project_ehab/widgets/favorites.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user=FirebaseAuth.instance.currentUser;
    final userID=user!.uid;

    return Scaffold(
      backgroundColor: ColorManager.primary,
     body: SafeArea(
       child: fetchData("users-favourite-movies"),
     ),
    );
  }
}
