
import 'package:books/my_home_page/search/categories/categories_screen.dart';
import 'package:books/my_home_page/search/search_box/search_box_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPublishersProvider = StateProvider<List<String>>((ref) => []);
final selectedCategoriesProvider = StateProvider<List<String>>((ref) => []);

class SearchScreen extends ConsumerWidget {
  final List<String> publishers = [
    'Arihant',
    'Mc-Graw',
    'Prabhat',
    'NCERT',
    'S.Chand',
    'Pearson',
  ];
  final List<String> categories = [
    'History',
    'Science',
    'Design',
    'English',
    'Political Science',
    'Fairy Tales Stories',
  ];

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPublishers = ref.watch(selectedPublishersProvider);
    final selectedCategories = ref.watch(selectedCategoriesProvider);

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
        vertical: size.height * 0.02,
      ),
      child: ListView(
        children: [
          SearchBarContainer(
            size: size,
            enabled: true,
            voidCallback: () {},
            title: "India art and culture",
          ),

          Text(
            "Publisher",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.06,
            ),
          ),
          Wrap(
            spacing: 10,
            children:
            publishers.map((p) {
              final isSelected = selectedPublishers.contains(p);
              return FilterChip(
                label: Text(p),
                selected: isSelected,
                onSelected: (selected) {
                  final updatedList = [...selectedPublishers];
                  if (selected) {
                    updatedList.add(p);
                  } else {
                    updatedList.remove(p);
                  }
                  ref.read(selectedPublishersProvider.notifier).state =
                      updatedList;
                },
                selectedColor: Colors.deepPurple,
                backgroundColor: Colors.grey[850],
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          Text(
            "Categories",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.06,
            ),
          ),
          CategoryListScreen(),
        ],
      ),
    );
  }
}

class CategoryListScreen extends ConsumerWidget {
  final List<String> categories = [
    'History',
    'Science',
    'Design',
    'English',
    'Political Science',
    'Fairy Tales Stories',
    'Mathematics',
    'Technology',
    'Philosophy',
    'Music',
  ];

  CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showAll = ref.watch(showAllProvider);

    final displayedCategories =
    showAll ? categories : categories.take(5).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...displayedCategories.map(
                (category) => ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, "/searchContainer",arguments: {"title":category});
                  },
              title: Text(category),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              ref.read(showAllProvider.notifier).state = !showAll;
            },
            child: Text(
              showAll ? 'See less <' : 'See all >',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final showAllProvider = StateProvider<bool>((ref) => false);