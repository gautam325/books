import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../profile/edit_profile/edit_profile_page.dart';
import '../profile/edit_profile/profile_model/profile_model.dart';

class CustomGreetingAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomGreetingAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final profile = ref.watch(profileProvider);

    return PreferredSize(
      preferredSize: Size.fromHeight(size.height * 0.12),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: size.width * 0.06,
                    backgroundImage: profile.image != null ? FileImage(profile.image!) : null,
                    child: profile.image == null
                        ? Icon(Icons.person, size: size.width * 0.08)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: size.width * 0.026,
                      height: size.width * 0.026,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Text(
                "Hello, ${profile.name.isNotEmpty ? profile.name : 'Guest'}",
                style: TextStyle(fontSize: size.width * 0.045, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 30);
}
