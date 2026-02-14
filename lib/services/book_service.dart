import 'package:books/model/book.dart';
import 'package:books/model/category.dart';

class BookService {
  Future<List<Category>> fetchCategories() async {
    return const [
      Category(id: 1, name: 'Programming'),
      Category(id: 2, name: 'Novel'),
      Category(id: 3, name: 'Self Help'),
      Category(id: 4, name: 'Business'),
      Category(id: 5, name: 'Education'),
    ];
  }

  Future<List<Book>> fetchBooks() async {
    final now = DateTime.now();
    return [
      Book(
        id: 1,
        title: 'Clean Code',
        author: 'Robert C. Martin',
        description: 'A handbook of agile software craftsmanship.',
        price: 19.99,
        categoryId: 1,
        imageUrl: 'https://picsum.photos/200/300?1',
        rating: 4.8,
        createdAt: now.subtract(const Duration(days: 30)),
        pdfUrl: 'https://example.com/clean-code.pdf',
      ),
      Book(
        id: 2,
        title: 'Atomic Habits',
        author: 'James Clear',
        description: 'An easy and proven way to build good habits.',
        price: 14.50,
        categoryId: 3,
        imageUrl: 'https://picsum.photos/200/300?2',
        rating: 4.7,
        createdAt: now.subtract(const Duration(days: 10)),
      ),
      Book(
        id: 3,
        title: 'The Lean Startup',
        author: 'Eric Ries',
        description: 'How today entrepreneurs use continuous innovation.',
        price: 16.75,
        categoryId: 4,
        imageUrl: 'https://picsum.photos/200/300?3',
        rating: 4.5,
        createdAt: now.subtract(const Duration(days: 7)),
      ),
      Book(
        id: 4,
        title: 'The Alchemist',
        author: 'Paulo Coelho',
        description: 'A magical story about following your dreams.',
        price: 11.20,
        categoryId: 2,
        imageUrl: 'https://picsum.photos/200/300?4',
        rating: 4.3,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
    ];
  }
}
