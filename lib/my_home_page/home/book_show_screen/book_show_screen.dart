import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageProvider = StateProvider<int>((ref) => 0);
final controllerPageHeight = StateProvider<bool>((ref) => false);

class BookShowScreen extends ConsumerStatefulWidget {
  const BookShowScreen({super.key});

  @override
  ConsumerState<BookShowScreen> createState() => _BookShowScreenState();
}

class _BookShowScreenState extends ConsumerState<BookShowScreen> {
  late final List<String> pages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final longText =
        "    In a quiet corner of the ancient city, a young scholar sat beneath a fading banyan tree, "
            "scribbling thoughts into a worn journal. The marketplace buzzed in the distance, but he remained undisturbed, "
            "consumed by the words forming in his mind. He believed that knowledge was the true weapon of any age, sharper than "
            "a blade and more enduring than stone. It was here that he would conceive ideas that would eventually change the course "
            "of history—not with war, but with wisdom. The sun dipped lower, casting golden rays across the pages, and still, he wrote." *
            10;

    pages = splitTextIntoPagesByScreenSize(
      context: context,
      text: longText,
      textStyle: const TextStyle(fontSize: 17), // Increased text size
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(currentPageProvider);
    final boolValuePage = ref.watch(controllerPageHeight);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: boolValuePage?size.height*.84:size.height*.76,
                child: GestureDetector(
                  onTap: () {
                    ref.read(controllerPageHeight.notifier).state =
                    !ref.read(controllerPageHeight.notifier).state;
                  },
                  child: PageView.builder(
                    itemCount: pages.length,
                    onPageChanged: (index) {
                      ref.read(currentPageProvider.notifier).state = index;
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          pages[index],
                          style: const TextStyle(fontSize: 15.5),
                          textAlign: TextAlign.justify,
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (boolValuePage)
                Slider(
                  value: (currentPage + 1).toDouble(),
                  min: 1,
                  max: pages.length.toDouble(),
                  onChanged: (value) {
                    ref.read(currentPageProvider.notifier).state = value.toInt() - 1;
                  },
                  activeColor: Colors.blueAccent,
                  inactiveColor: Colors.grey,
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> splitTextIntoPagesByScreenSize({
    required BuildContext context,
    required String text,
    required TextStyle textStyle,
  }) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    const double reservedHeight = 150;
    final double maxHeight = screenHeight - reservedHeight;
    final double maxWidth = screenWidth - 30;

    final List<String> paragraphs = text.trim().split(RegExp(r'\n\s*\n|(?<=\.\s{2,})'));
    final List<String> pages = [];

    int start = 0;

    while (start < paragraphs.length) {
      int end = start + 1;

      while (end <= paragraphs.length) {
        final currentText = paragraphs.sublist(start, end).join(' ');
        final textSpan = TextSpan(text: currentText, style: textStyle);
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.justify,
          maxLines: null,
        );
        textPainter.layout(maxWidth: maxWidth);

        if (textPainter.size.height > maxHeight) break;
        end++;
      }

      pages.add(paragraphs.sublist(start, end - 1).join(' '));
      start = end - 1;
    }

    return pages;
  }
}
