import 'package:final_project_ehab/pages/login/login_test.dart';
import 'package:final_project_ehab/pages/main/main_view.dart';
import 'package:final_project_ehab/resourses/color_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,

      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("There Something Wrong"),
            );
          } else if (snapshot.hasData) {
            return const MainView();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
