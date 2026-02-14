import 'package:books/view/auth/login_screen.dart';
import 'package:books/view/auth/register_screen.dart';
import 'package:books/view/auth/forgot_password_screen.dart';
import 'package:books/view/book/book_details_screen.dart';
import 'package:books/view/home/home_screen.dart';
import 'package:books/view/splash_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
    GetPage(name: AppRoutes.forgotPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.details, page: () => const BookDetailsScreen()),
  ];
}
