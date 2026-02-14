class Book {
  final int id;
  final String title;
  final String author;
  final String description;
  final double price;
  final int categoryId;
  final String imageUrl;
  final double rating;
  final DateTime createdAt;
  final String? pdfUrl;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.imageUrl,
    required this.rating,
    required this.createdAt,
    this.pdfUrl,
  });
}
