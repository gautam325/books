import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'library_contain/library_screen.dart';

final selectedTabProvider = StateProvider<String>((ref) => 'All');

class ToggleTab extends ConsumerWidget {
  final List<String> tabs;
  final Size size;

  const ToggleTab({super.key, this.tabs = const ['All', 'Downloaded'],required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);

    return Container(
      height: size.height*.05,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: tabs.map((label) {
          final isSelected = selectedTab == label;
          return Expanded(
            child: GestureDetector(
              onTap: () => ref.read(selectedTabProvider.notifier).state = label,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.deepPurple : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width*.045
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}