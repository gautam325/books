import 'package:books/my_home_page/home/book_information/book_information_screen.dart';
import 'package:books/my_home_page/home/book_show_screen/book_show_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../my_home_page.dart';
import '../search/search_box/search_box_container.dart';

final selectedCategoryProvider = StateProvider<String?>((ref) => null);


class Home extends ConsumerWidget {
  final List<String> categories = ['Top Search', 'Science', 'Design'];

  Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
        vertical: size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Field
          SearchBarContainer(size: size, enabled: false,voidCallback: (){
            ref.read(selectedIndexProvider.notifier).state = 1;
          },title: "Search books, what do you want...",),

          ...categories.map((category) => buildCategorySection(ref, category, size)),
        ],
      ),
    );
  }

  Widget buildCategorySection(WidgetRef ref, String title, Size size) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            ref.read(selectedCategoryProvider.notifier).state = title;
          },
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontWeight: FontWeight.bold,
                  color: selectedCategory == title
                      ? Colors.deepPurpleAccent
                      : Colors.white,
                ),
              ),
              if (selectedCategory == title)
                const Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Icon(Icons.check_circle, color: Colors.deepPurpleAccent, size: 18),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: size.height * 0.22,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/informationPage");
                  },

                  child: Container(
                    width: size.width * 0.32,
                    decoration: BoxDecoration(
                      color: Colors.primaries[index % Colors.primaries.length].shade400,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Book ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

}