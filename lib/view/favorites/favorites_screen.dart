import 'package:books/controller/book_controller.dart';
import 'package:books/controller/favorites_controller.dart';
import 'package:books/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Get.find<FavoritesController>();
    final books = Get.find<BookController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Obx(() {
        final favoriteBooks = books.books.where((b) => favorites.favoriteIds.contains(b.id)).toList();
        if (favoriteBooks.isEmpty) {
          return const Center(child: Text('No favorite books yet'));
        }
        return ListView.builder(
          itemCount: favoriteBooks.length,
          itemBuilder: (_, index) {
            final book = favoriteBooks[index];
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(book.imageUrl)),
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => Get.toNamed(AppRoutes.details, arguments: book),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () => favorites.toggleFavorite(book),
              ),
            );
          },
        );
      }),
    );
  }
}
