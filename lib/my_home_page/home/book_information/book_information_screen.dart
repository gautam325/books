import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Main Screen displaying books and genres
class BookInformationScreen extends ConsumerWidget {
  const BookInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final selectedGenre = ref.watch(selectedGenreProvider);
    final books = ref.watch(filteredBooksProvider);

    // Static genre list
    final genres = [
      'History',
      'Science',
      'Design',
      'English',
      'Political Science',
      'Fairy Tales & Stories',
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: ListView(
            children: [
              // Reading Card
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/pdfPage");
                },
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B57FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth * 0.15,
                        height: screenHeight * 0.12,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Continue reading",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "The Witches of Willow Cove",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.045,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Chapter 8",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: screenWidth * 0.032,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: const LinearProgressIndicator(
                                value: 0.8,
                                backgroundColor: Colors.white24,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                                minHeight: 6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Genre Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: genres.map((genre) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: GestureDetector(
                        onTap: () {
                          ref.read(selectedGenreProvider.notifier).state = genre;
                        },
                        child: GenreChip(
                          label: genre,
                          isActive: genre == selectedGenre,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Filtered Book List
              ...books.map(
                    (book) => InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, "/informationPage");
                      },
                      child: BookTile(
                                        title: book.title,
                                        author: book.author,
                                        duration: book.duration,
                                        rating: book.rating,
                                        imageUrl: book.imageUrl,
                                        width: screenWidth,
                                        height: screenHeight,
                                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// GenreChip Widget
class GenreChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final double fontSize;

  const GenreChip({
    super.key,
    required this.label,
    this.isActive = false,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: isActive ? Colors.deepPurple : Colors.grey.shade200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      label: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.black,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

// BookTile Widget
class BookTile extends StatelessWidget {
  final String title;
  final String author;
  final String duration;
  final double rating;
  final String imageUrl;
  final double width;
  final double height;

  const BookTile({
    super.key,
    required this.title,
    required this.author,
    required this.duration,
    required this.rating,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: height * 0.01),
      leading: Container(
        width: width * 0.14,
        height: height * 0.11,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(6),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: imageUrl.isNotEmpty
              ? Image.network(imageUrl, fit: BoxFit.cover)
              : const Icon(Icons.book_outlined), // placeholder if no image
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.04),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(author, style: TextStyle(fontSize: width * 0.035)),
          SizedBox(height: height * 0.005),
          Text(duration, style: TextStyle(fontSize: width * 0.03)),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 18),
          Text(rating.toString()),
        ],
      ),
    );
  }
}

// Book model
class Book {
  final String title;
  final String author;
  final String duration;
  final double rating;
  final String imageUrl;
  final String genre;

  Book({
    required this.title,
    required this.author,
    required this.duration,
    required this.rating,
    required this.imageUrl,
    required this.genre,
  });
}

// Riverpod Providers
final selectedGenreProvider = StateProvider<String>((ref) => 'History');

final bookListProvider = Provider<List<Book>>((ref) {
  return [
    Book(
      title: "The Witches of Willow Cove",
      author: "Josh Roberts",
      duration: "7h 15min",
      rating: 4.7,
      imageUrl: "https://covers.openlibrary.org/b/id/10581769-L.jpg",
      genre: "History",
    ),
    Book(
      title: "The Wicked Deep",
      author: "Shea Ernshaw",
      duration: "6h 20min",
      rating: 4.5,
      imageUrl: "https://covers.openlibrary.org/b/id/8897491-L.jpg",
      genre: "Science",
    ),
    Book(
      title: "The Wicked Deep",
      author: "Shea Ernshaw",
      duration: "6h 20min",
      rating: 4.5,
      imageUrl: "https://covers.openlibrary.org/b/id/8897491-L.jpg",
      genre: "Science",
    ),
    Book(
      title: "The Lost Ones",
      author: "Anita Frank",
      duration: "6h 42min",
      rating: 4.6,
      imageUrl: "https://covers.openlibrary.org/b/id/10423256-L.jpg",
      genre: "History",
    ),
    Book(
      title: "The Lost Ones",
      author: "Anita Frank",
      duration: "6h 42min",
      rating: 4.6,
      imageUrl: "https://covers.openlibrary.org/b/id/10423256-L.jpg",
      genre: "Design",
    ),
    Book(
      title: "The Lost Ones",
      author: "Anita Frank",
      duration: "6h 42min",
      rating: 4.6,
      imageUrl: "https://covers.openlibrary.org/b/id/10423256-L.jpg",
      genre: "English",
    ),
    Book(
      title: "The Lost Ones",
      author: "Anita Frank",
      duration: "6h 42min",
      rating: 4.6,
      imageUrl: "https://covers.openlibrary.org/b/id/10423256-L.jpg",
      genre: "English",
    ),
    Book(
      title: "The Lost Ones",
      author: "Anita Frank",
      duration: "6h 42min",
      rating: 4.6,
      imageUrl: "https://covers.openlibrary.org/b/id/10423256-L.jpg",
      genre: "English",
    ),
    Book(
      title: "The Lost Ones",
      author: "Anita Frank",
      duration: "6h 42min",
      rating: 4.6,
      imageUrl: "https://covers.openlibrary.org/b/id/10423256-L.jpg",
      genre: "Fairy Tales & Stories",
    ),
    Book(
      title: "The Lost Ones",
      author: "Anita Frank",
      duration: "6h 42min",
      rating: 4.6,
      imageUrl: "https://covers.openlibrary.org/b/id/10423256-L.jpg",
      genre: "Fairy Tales & Stories",
    ),
    Book(
      title: "The Lost Ones",
      author: "Anita Frank",
      duration: "6h 42min",
      rating: 4.6,
      imageUrl: "https://covers.openlibrary.org/b/id/10423256-L.jpg",
      genre: "Fairy Tales & Stories",
    ),
    Book(
      title: "The Lost Ones",
      author: "Anita Frank",
      duration: "6h 42min",
      rating: 4.6,
      imageUrl: "https://covers.openlibrary.org/b/id/10423256-L.jpg",
      genre: "Fairy Tales & Stories",
    ),
    Book(
      title: "The Lost Ones",
      author: "Anita Frank",
      duration: "6h 42min",
      rating: 4.6,
      imageUrl: "https://covers.openlibrary.org/b/id/10423256-L.jpg",
      genre: "English",
    ),
    Book(
      title: "World History Basics",
      author: "John Doe",
      duration: "5h 10min",
      rating: 4.2,
      imageUrl: "",
      genre: "History",
    ),
    Book(
      title: "Science of the Universe",
      author: "Jane Astro",
      duration: "8h 0min",
      rating: 4.8,
      imageUrl: "",
      genre: "Science",
    ),
    Book(
      title: "Science of the Universe",
      author: "Jane Astro",
      duration: "8h 0min",
      rating: 4.8,
      imageUrl: "",
      genre: "Political Science",
    ),
    Book(
      title: "Science of the Universe",
      author: "Jane Astro",
      duration: "8h 0min",
      rating: 4.8,
      imageUrl: "",
      genre: "Political Science",
    ),
    Book(
      title: "Science of the Universe",
      author: "Jane Astro",
      duration: "8h 0min",
      rating: 4.8,
      imageUrl: "",
      genre: "Political Science",
    ),
    Book(
      title: "Science of the Universe",
      author: "Jane Astro",
      duration: "8h 0min",
      rating: 4.8,
      imageUrl: "",
      genre: "Political Science",
    ),
  ];
});

final filteredBooksProvider = Provider<List<Book>>((ref) {
  final selectedGenre = ref.watch(selectedGenreProvider);
  final allBooks = ref.watch(bookListProvider);
  return allBooks.where((book) => book.genre == selectedGenre).toList();
});
