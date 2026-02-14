import 'package:books/controller/auth_controller.dart';
import 'package:books/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: appInputDecoration('Name'),
                validator: (value) => validateRequired(value, 'Name'),
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmCtrl,
                decoration: appInputDecoration('Confirm Password'),
                obscureText: true,
                validator: (value) {
                  final required = validateRequired(value, 'Confirm Password');
                  if (required != null) return required;
                  if (value != _passwordCtrl.text) return 'Passwords do not match';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: auth.isLoading.value
                        ? null
                        : () {
                            if (!_formKey.currentState!.validate()) return;
                            auth.register(_nameCtrl.text.trim(), _emailCtrl.text.trim(), _passwordCtrl.text.trim());
                          },
                    child: Text(auth.isLoading.value ? 'Loading...' : 'Register'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
