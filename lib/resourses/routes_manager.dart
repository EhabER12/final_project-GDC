import 'package:final_project_ehab/pages/favorites/favorites_view.dart';
import 'package:final_project_ehab/pages/login/login_test.dart';
import 'package:final_project_ehab/resourses/strings_manager.dart';
import 'package:flutter/material.dart';
//import '../pages/login/login_view.dart';
import '../pages/login/login_view.dart';
import '../pages/main/main_view.dart';
import '../pages/register/register_view.dart';
import '../pages/splash/splash_view.dart';

class Routes{
  static const String loginTest="/login_test";
  static const String splashRoute="/";
  static const String loginRoute="/login";
  static const String onBoardingRoute="/onBoarding";
  static const String registerRoute="/register";
  static const String forgotPasswordRoute="/forgotPassword";
  static const String mainRoute="/main";
  static const String storeDetailsRoute="/storeDetails";
  static const String favoritesRoute="/favorites";

}
class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_)=>const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_)=>const LoginView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_)=>const MainView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_)=>const RegisterView());
      case Routes.loginTest:
        return MaterialPageRoute(builder: (_)=>LoginScreen());
      case Routes.favoritesRoute:
        return MaterialPageRoute(builder: (_)=>const Favorites());

      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(builder: (_)=>Scaffold(
      appBar: AppBar(title: const Text(AppStrings.noRouteFound),),
    ));

  }
}