import 'package:books/model/book.dart';
import 'package:books/model/category.dart';
import 'package:books/services/book_service.dart';
import 'package:get/get.dart';

enum SortType { price, rating, newest }

class BookController extends GetxController {
  final BookService _service = BookService();
  final books = <Book>[].obs;
  final categories = <Category>[].obs;
  final selectedCategoryId = 0.obs;
  final searchText = ''.obs;
  final selectedSort = SortType.newest.obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  Future<void> loadData() async {
    categories.assignAll(await _service.fetchCategories());
    books.assignAll(await _service.fetchBooks());
  }

  List<Book> get filteredBooks {
    var list = books.where((book) {
      final categoryMatch = selectedCategoryId.value == 0 || book.categoryId == selectedCategoryId.value;
      final queryMatch = book.title.toLowerCase().contains(searchText.value.toLowerCase());
      return categoryMatch && queryMatch;
    }).toList();

    switch (selectedSort.value) {
      case SortType.price:
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortType.rating:
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortType.newest:
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }

    return list;
  }
}
