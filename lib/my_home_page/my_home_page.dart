import 'package:books/my_home_page/custom_appbar/custom_appbar.dart';
import 'package:books/my_home_page/library/library_contain/library_screen.dart';
import 'package:books/my_home_page/profile/profile_screen.dart';
import 'package:books/my_home_page/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home/home.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class MyHomePage extends ConsumerWidget {
  final List<IconData> _icons = [
    Icons.home,
    Icons.search,
    Icons.library_books,
    Icons.person,
  ];

  List labels = ['Home', 'Search', 'Library', 'Profile'];
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: selectedIndex == 3 ? null : CustomGreetingAppBar(),
      body: IndexedStack(
        index: selectedIndex,
        children: [Home(), SearchScreen(), LibraryScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 78,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 7.0,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildNavItem(ref, 0, _icons[0], labels[0]),
                  buildNavItem(ref, 1, _icons[1], labels[1]),
                  buildNavItem(ref, 2, _icons[2], labels[2]),
                  buildNavItem(ref, 3, _icons[3], labels[3]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(WidgetRef ref, int index, IconData icon, String label) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => ref.read(selectedIndexProvider.notifier).state = index,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.white : Colors.grey, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[900],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
