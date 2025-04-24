import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileModel {
  final String name;
  final String email;
  final String phone;
  final File? image;

  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    this.image,
  });
}

class ProfileNotifier extends StateNotifier<ProfileModel> {
  ProfileNotifier()
    : super(ProfileModel(name: '', email: '', phone: '', image: null)) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? '';
    final email = prefs.getString('email') ?? '';
    final phone = prefs.getString('phone') ?? '';
    final base64Image = prefs.getString('profileImage');

    File? imageFile;
    if (base64Image != null) {
      final bytes = base64Decode(base64Image);
      final path = '${Directory.systemTemp.path}/profile.png';
      imageFile = File(path)..writeAsBytesSync(bytes);
    }

    state = ProfileModel(
      name: name,
      email: email,
      phone: phone,
      image: imageFile,
    );
  }

  Future<void> updateProfile(ProfileModel newProfile) async {
    final prefs = await SharedPreferences.getInstance();
    state = newProfile;

    await prefs.setString('name', newProfile.name);
    await prefs.setString('email', newProfile.email);
    await prefs.setString('phone', newProfile.phone);

    if (newProfile.image != null) {
      final bytes = await newProfile.image!.readAsBytes();
      final base64Image = base64Encode(bytes);
      await prefs.setString('profileImage', base64Image);
    }
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileModel>((
  ref,
) {
  return ProfileNotifier();
});
