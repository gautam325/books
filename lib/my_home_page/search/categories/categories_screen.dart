import 'package:books/my_home_page/library/library_contain/books_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerWidget {
  final String? title;
  const CategoriesScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> books = List.generate(15, (index) => 'Book $index');

    return Scaffold(
      appBar: AppBar(title: Text("$title")),
      body: BooksGrid(books: books,voidCallback: (){
        Navigator.pushNamed(context, "/informationPage");
      },),
    );
  }
}
