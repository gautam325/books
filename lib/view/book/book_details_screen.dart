import 'package:books/controller/cart_controller.dart';
import 'package:books/controller/favorites_controller.dart';
import 'package:books/model/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final book = Get.arguments as Book;
    final cart = Get.find<CartController>();
    final favorites = Get.find<FavoritesController>();

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: 'book_${book.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(book.imageUrl, height: 300, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 16),
          Text(book.title, style: Theme.of(context).textTheme.headlineSmall),
          Text('by ${book.author}'),
          const SizedBox(height: 8),
          Row(children: [Icon(Icons.star, color: Colors.amber.shade700), Text('${book.rating}')]),
          Text('\$${book.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(book.description),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => cart.addToCart(book),
            icon: const Icon(Icons.shopping_cart),
            label: const Text('Add to Cart'),
          ),
          const SizedBox(height: 8),
          Obx(
            () => OutlinedButton.icon(
              onPressed: () => favorites.toggleFavorite(book),
              icon: Icon(favorites.isFavorite(book.id) ? Icons.favorite : Icons.favorite_border),
              label: Text(favorites.isFavorite(book.id) ? 'Remove from Favorite' : 'Add to Favorite'),
            ),
          ),
          if (book.pdfUrl != null)
            TextButton.icon(
              onPressed: () => Get.snackbar('Read Book', 'Download/Read feature can open PDF URL.'),
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Read / Download PDF'),
            ),
        ],
      ),
    );
  }
}
