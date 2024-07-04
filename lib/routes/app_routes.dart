
import 'package:flutter/material.dart';
import 'package:machine_test/network/models/response/auth/login_response.dart';
import '../modules/auth/login/screens/login_screen.dart';
import '../modules/auth/user_register/screens/user_registration_screen.dart';
import '../modules/home/screens/home_screen.dart';
import 'route_name.dart';
class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case RouteName.loginScreen:
        String email=settings.arguments==null?'':settings.arguments as String;
        return MaterialPageRoute(builder: (context) =>  LoginScreen(email:email));

      case RouteName.homeScreen:
        UserRecord? record=settings.arguments as UserRecord;
        return MaterialPageRoute(builder: (context) =>  HomeScreen(record: record,));
   case RouteName.userRegistrationScreen :
        return MaterialPageRoute(builder: (context) =>  const UserRegistrationScreen());
      default:
        return MaterialPageRoute(builder: (context) =>  const LoginScreen(email: '',));
    }
  }
}
