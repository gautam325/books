import 'package:books/controller/book_controller.dart';
import 'package:books/routes/app_routes.dart';
import 'package:books/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Book Store')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(
          () => Column(
            children: [
              TextField(
                decoration: appInputDecoration('Search by title').copyWith(prefixIcon: const Icon(Icons.search)),
                onChanged: (value) => controller.searchText.value = value,
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ChoiceChip(
                      label: const Text('All'),
                      selected: controller.selectedCategoryId.value == 0,
                      onSelected: (_) => controller.selectedCategoryId.value = 0,
                    ),
                    ...controller.categories.map(
                      (cat) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ChoiceChip(
                          label: Text(cat.name),
                          selected: controller.selectedCategoryId.value == cat.id,
                          onSelected: (_) => controller.selectedCategoryId.value = cat.id,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton<SortType>(
                value: controller.selectedSort.value,
                items: const [
                  DropdownMenuItem(value: SortType.newest, child: Text('Sort: Newest')),
                  DropdownMenuItem(value: SortType.price, child: Text('Sort: Price')),
                  DropdownMenuItem(value: SortType.rating, child: Text('Sort: Rating')),
                ],
                onChanged: (value) => controller.selectedSort.value = value ?? SortType.newest,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: controller.filteredBooks.isEmpty
                    ? const Center(child: Text('No books found'))
                    : GridView.builder(
                        itemCount: controller.filteredBooks.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: .65,
                        ),
                        itemBuilder: (context, index) {
                          final book = controller.filteredBooks[index];
                          return InkWell(
                            onTap: () => Get.toNamed(AppRoutes.details, arguments: book),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kCardRadius)),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Hero(
                                        tag: 'book_${book.id}',
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(book.imageUrl, width: double.infinity, fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(book.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                                    Text('\$${book.price.toStringAsFixed(2)}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
