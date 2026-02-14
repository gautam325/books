import 'package:books/model/book.dart';
import 'package:books/model/cart_item.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final items = <CartItem>[].obs;

  void addToCart(Book book) {
    final existing = items.firstWhereOrNull((item) => item.book.id == book.id);
    if (existing != null) {
      existing.quantity += 1;
      items.refresh();
      return;
    }
    items.add(CartItem(book: book));
  }

  void removeFromCart(int bookId) => items.removeWhere((item) => item.book.id == bookId);

  void increaseQty(int bookId) {
    final item = items.firstWhereOrNull((e) => e.book.id == bookId);
    if (item != null) {
      item.quantity += 1;
      items.refresh();
    }
  }

  void decreaseQty(int bookId) {
    final item = items.firstWhereOrNull((e) => e.book.id == bookId);
    if (item == null) return;
    if (item.quantity == 1) {
      removeFromCart(bookId);
    } else {
      item.quantity -= 1;
      items.refresh();
    }
  }

  double get totalPrice => items.fold(0, (sum, item) => sum + item.total);

  void checkout() {
    if (items.isNotEmpty) {
      Get.snackbar('Checkout', 'Order placed successfully!');
      items.clear();
    }
  }
}
