import 'package:books/controller/auth_controller.dart';
import 'package:books/controller/book_controller.dart';
import 'package:books/controller/cart_controller.dart';
import 'package:books/controller/favorites_controller.dart';
import 'package:books/routes/app_pages.dart';
import 'package:books/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController(), permanent: true);
  Get.put(BookController(), permanent: true);
  Get.put(FavoritesController(), permanent: true);
  Get.put(CartController(), permanent: true);
  runApp(const BookStoreApp());
}

class BookStoreApp extends StatelessWidget {
  const BookStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
