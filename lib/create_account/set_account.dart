import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../create_account/create_account.dart';

final authProvider = StateProvider<bool>((ref) => false);

class SetAccount extends ConsumerStatefulWidget {
  const SetAccount({super.key});

  @override
  ConsumerState<SetAccount> createState() => _SetAccountState();
}

class _SetAccountState extends ConsumerState<SetAccount> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    ref.read(authProvider.notifier).state = isLoggedIn;

    // Delay to show splash for a bit (optional)
    await Future.delayed(const Duration(seconds: 1));

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      Navigator.pushReplacementNamed(context, '/loginPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
