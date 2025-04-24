import 'dart:io';
import 'package:books/my_home_page/profile/edit_profile/profile_model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../custom_text_field_screen.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    nameController = TextEditingController(text: profile.name);
    emailController = TextEditingController(text: profile.email);
    phoneController = TextEditingController(text: profile.phone);
    selectedImage = profile.image;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final updated = ProfileModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      image: selectedImage,
    );
    await ref.read(profileProvider.notifier).updateProfile(updated);

    if (mounted) {
      Navigator.pop(context); // close loading
      Navigator.pop(context); // return to profile screen
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.15,
                    backgroundImage:
                        selectedImage != null
                            ? FileImage(selectedImage!)
                            : null,
                    child:
                        selectedImage == null
                            ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            )
                            : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: screenWidth * 0.05,
                      backgroundColor: theme.colorScheme.primary,
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              label: "Name",
              icon: Icons.person,
              textEditingController: nameController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: "Email",
              icon: Icons.email,
              textEditingController: emailController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: "Phone",
              icon: Icons.phone,
              textEditingController: phoneController,
            ),
            const SizedBox(height: 40),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: _saveProfile,
            //     child: const Text("Save"),
            //   ),
            // ),
            SizedBox(
              width: double.infinity,
              height: screenHeight*.15,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical:  screenHeight* 0.02),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Save", style: TextStyle(fontSize: 18,color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
