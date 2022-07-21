import 'package:final_project_ehab/pages/main/main_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login/login_test.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.data == null) {
            print('User didn\'t login yet');
            return LoginScreen();
          } else if (userSnapshot.hasData) {
            print('User is logged in');
            return const MainView();
          } else if (userSnapshot.hasError) {
            return const Center(
              child: Text(
                'An error has been occured',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ),
          );
        });
  }
}
