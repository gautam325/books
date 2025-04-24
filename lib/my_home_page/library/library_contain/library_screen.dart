import 'package:books/my_home_page/library/library_contain/books_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../toggle_tab.dart' show ToggleTab;

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final List<String> books = List.generate(12, (index) => 'Book $index');

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.02,
          vertical: screenSize.height * 0.02,
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height*.01,
            ),
            ToggleTab(size: screenSize,),
            SizedBox(height: screenSize.height * 0.02),
            BooksGrid(books: books,voidCallback: (){
             Navigator.pushNamed(context, "/informationPage");
            },),
          ],
        ),
      ),
    );
  }
}



