import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextField extends ConsumerWidget {
  final String label;
  final IconData? icon;
  final String? hintText;
  final int maxLines;
  final TextInputType keyboardType;
  final TextEditingController? textEditingController;

  const CustomTextField({
    super.key,
    required this.label,
    this.icon,
    this.hintText,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
     this.textEditingController,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: Colors.white70) : null,
        labelText: label,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white38),
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white54),
        ),
      ),
    );
  }
}
