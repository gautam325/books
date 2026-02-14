import 'package:books/controller/auth_controller.dart';
import 'package:books/routes/app_routes.dart';
import 'package:books/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailCtrl,
                decoration: appInputDecoration('Email'),
                validator: validateEmail,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordCtrl,
                decoration: appInputDecoration('Password'),
                obscureText: true,
                validator: validatePassword,
              ),
              const SizedBox(height: 16),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: auth.isLoading.value
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              auth.login(_emailCtrl.text.trim(), _passwordCtrl.text.trim());
                            }
                          },
                    child: Text(auth.isLoading.value ? 'Loading...' : 'Login'),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => Get.snackbar('Google Login', 'Google login can be added using Firebase/Auth provider.'),
                icon: const Icon(Icons.login),
                label: const Text('Continue with Google (Optional)'),
              ),
              TextButton(onPressed: () => Get.toNamed(AppRoutes.register), child: const Text('Register')),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                child: const Text('Forgot Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
