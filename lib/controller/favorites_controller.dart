import 'package:books/model/book.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final favoriteIds = <int>{}.obs;

  bool isFavorite(int bookId) => favoriteIds.contains(bookId);

  void toggleFavorite(Book book) {
    if (isFavorite(book.id)) {
      favoriteIds.remove(book.id);
    } else {
      favoriteIds.add(book.id);
    }
  }
}
