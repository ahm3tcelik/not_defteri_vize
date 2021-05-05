import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  final authService = FirebaseAuth.instance;
  @override
  int? priority =  0;

  @override
  RouteSettings? redirect(String? route) {
    var isLoggedIn = authService.currentUser != null;
    if (isLoggedIn) {
      // Block the sign in or sign-up page when is logged in
      if (route == AppRoutes.SIGN_IN || route == AppRoutes.SIGN_UP) {
        return RouteSettings(name: AppRoutes.HOME);
      }
      return null;
    }
    else {
      // Redirect to sign-in page when route requiring the auth
      return RouteSettings(name: AppRoutes.SIGN_IN);
    }
  }
}