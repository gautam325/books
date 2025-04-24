import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'edit_profile/profile_model/profile_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.02),
      child: Column(
        children: [
          SizedBox(height: size.height * .06),
          CircleAvatar(
            radius: size.width * 0.12,
            backgroundImage: profile.image != null ? FileImage(profile.image!) : null,
            child: profile.image == null ? Icon(Icons.person, size: size.width * 0.09) : null,
          ),
          const SizedBox(height: 12),
          Text(
            profile.name.isNotEmpty ? profile.name : 'Your Name',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 30),
          buildMenuItem("Edit profile", context, size, () async {
            await Navigator.pushNamed(context, "/editProfile");
            ref.invalidate(profileProvider);
            ref.read(profileProvider.notifier).loadProfile();
          }),
          buildMenuItem("Payment", context, size, () {
            Navigator.pushNamed(context, "/paymentScreen");
          }),
          buildMenuItem("Support", context, size, () {
            Navigator.pushNamed(context, "/supportScreen");
          }),
          buildMenuItem("About the app", context, size, () {
            Navigator.pushNamed(context, "/aboutAppPage");
          }),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Text('Log out', style: TextStyle(color: Colors.grey.shade600, fontSize: size.width * .05)),
          ),
          SizedBox(height: size.height * .03),
        ],
      ),
    );
  }

  Widget buildMenuItem(String title, BuildContext context, Size size, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * .005),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: size.width * .05),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white),
        onTap: onTap,
      ),
    );
  }
}
