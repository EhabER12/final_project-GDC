import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:final_project_ehab/pages/favorites/favorites_view.dart';
import 'package:final_project_ehab/resourses/assets_manager.dart';
import 'package:final_project_ehab/resourses/color_manager.dart';
import 'package:final_project_ehab/resourses/routes_manager.dart';
import 'package:final_project_ehab/services/errorhandle.dart';
import 'package:final_project_ehab/widgets/trending.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'elements.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;
  final screens = [
    Elements(),
    Favorites(),
  ];



  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home, size: 30),
      const Icon(Icons.favorite, size: 30),
    ];
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: const Image(
          image: AssetImage(ImageAssets.splashLogo),
          height: 50,
          width: 50,
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: ColorManager.darkGrey,
        child: Center(
          child: ElevatedButton.icon(
              onPressed: () async {
                signOut().then((value) =>
                    Navigator.popAndPushNamed(context, Routes.loginTest));
              },
              icon: const Icon(Icons.close),
              label: const Text("Sign Out")),
        ),
      ),
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        height: 50,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        index: index,
        color: const Color(0xff850101),
        onTap:(index) => setState(() => this.index = index),
        items: items,
      ),
    );
  }

  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      GlobalMethods.showErrorDialog(error: "$e", context: context);
    }
  }
}
