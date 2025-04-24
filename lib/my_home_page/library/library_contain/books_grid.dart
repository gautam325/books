import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksGrid extends ConsumerWidget {
 final List<String> books;
 final VoidCallback voidCallback;
   const BooksGrid({super.key,required this.books,required this.voidCallback});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: books.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {

        return GestureDetector(
          onTap: voidCallback,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.primaries[index % Colors.primaries.length].shade400,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  books[index],
                  textAlign: TextAlign.center,
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
    );
  }
}
