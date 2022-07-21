import 'dart:async';


import 'package:final_project_ehab/resourses/assets_manager.dart';
import 'package:final_project_ehab/resourses/fonts_manager.dart';
import 'package:final_project_ehab/resourses/styles_manager.dart';
import 'package:flutter/material.dart';

import '../../resourses/color_manager.dart';
import '../../resourses/constants_manager.dart';
import '../../resourses/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  _goNext(){
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
  Timer? _timer;
  _delayTimer(){
    _timer=Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }
  void initState(){
    super.initState();
    _delayTimer();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: ColorManager.primary,
      body: Center(child:Column(children: [
        const SizedBox(height: 200,),
      const Image(image:AssetImage(ImageAssets.splashLogo),height: 200,width: 300,),
      const SizedBox(height: 25,),
      Text("Movies APP",style: getBoldStyle(fontSize: FontSize.s22,color:ColorManager.white ),)
      ],)
    ));

  }
  @override
  dispose(){
    _timer?.cancel();
    super.dispose();
  }

}
