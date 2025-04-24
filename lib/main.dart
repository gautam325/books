import 'package:books/create_account/create_account.dart';
import 'package:books/create_account/set_account.dart';
import 'package:books/my_home_page/home/book_information/book_information_screen.dart';
import 'package:books/my_home_page/home/book_show_screen/book_show_screen.dart';
import 'package:books/my_home_page/my_home_page.dart';
import 'package:books/my_home_page/profile/about_app_page/about_app_page.dart';
import 'package:books/my_home_page/profile/edit_profile/edit_profile_page.dart';
import 'package:books/my_home_page/profile/payment/payment_screen.dart';
import 'package:books/my_home_page/profile/support/support_screen.dart';
import 'package:books/my_home_page/search/categories/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/setAccount',
      routes: {
        '/': (context) =>  MyHomePage(),
        '/setAccount': (context) => const SetAccount(),
        '/loginPage': (context) => const AuthFormPage(isLogin: true),
        '/createAccount': (context) => const AuthFormPage(isLogin: false),
        '/informationPage': (context) => const BookInformationScreen(),
        '/pdfPage': (context) => const BookShowScreen(),
        '/editProfile': (context) => const EditProfilePage(),
        '/paymentScreen': (context) => const PaymentPage(),
        '/supportScreen': (context) => const SupportScreen(),
        '/aboutAppPage': (context) => const AboutAppPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/searchContainer') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => CategoriesScreen(title: args['title']),
          );
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
