import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutAppPage extends ConsumerWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('About This App'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/logo.png'), // Replace with your app logo
            ),
            const SizedBox(height: 16),
            Text(
              "BookMate",
              style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              "Version 1.0.0",
              style: TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 20),
            const Text(
              "BookMate is your personalized library app that helps you discover, organize, and read books based on your favorite categories and publishers.",
              style: TextStyle(color: Colors.white70, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildFeature(Icons.category, "Browse books by category"),
            _buildFeature(Icons.filter_alt, "Filter by publisher"),
            _buildFeature(Icons.bookmark, "Bookmark your favorites"),
            _buildFeature(Icons.dark_mode, "Dark theme support"),
            const Spacer(),
            const Divider(color: Colors.white24),
            const Text(
              "Developed with ❤️ in Flutter",
              style: TextStyle(color: Colors.white38, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white60),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
