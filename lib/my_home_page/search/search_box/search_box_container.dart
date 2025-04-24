import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBarContainer extends ConsumerWidget {
  const SearchBarContainer({super.key,required this.size,required this.enabled,required this.voidCallback,required this.title});
  final Size size;
  final bool enabled;
  final VoidCallback voidCallback;
  final String title;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  GestureDetector(
      onTap: voidCallback,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: size.height * 0.07,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                enabled: enabled,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: title,
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Icon(Icons.filter_list, color: Colors.white),
          ],
        ),
      ),
    );
  }
}