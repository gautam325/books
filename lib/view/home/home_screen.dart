import 'package:books/controller/nav_controller.dart';
import 'package:books/view/cart/cart_screen.dart';
import 'package:books/view/favorites/favorites_screen.dart';
import 'package:books/view/home/home_tab.dart';
import 'package:books/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Get.put(NavController());
    final pages = const [HomeTab(), FavoritesScreen(), CartScreen(), ProfileScreen()];

    return Obx(
      () => Scaffold(
        body: pages[nav.selectedIndex.value],
        bottomNavigationBar: NavigationBar(
          selectedIndex: nav.selectedIndex.value,
          onDestinationSelected: (index) => nav.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
            NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
