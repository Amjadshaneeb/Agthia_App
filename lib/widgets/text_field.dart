import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Mytextfield extends StatelessWidget {
  const Mytextfield(
      {super.key,
      required this.hinttext,
      required this.obscure,
      required this.controller,
      required this.maxlines,
      this.textStyle,
      this.inputFormatters, this.numbers});
  final String hinttext;
  final int maxlines;
  final bool obscure;
  final TextEditingController controller;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? numbers;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required'; // Show this message if the field is empty
        }
        return null; // Return null if validation passes
      },
      inputFormatters: inputFormatters,
      obscureText: obscure,
      controller: controller,
      maxLines: maxlines,
      keyboardType: numbers,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
          border: const OutlineInputBorder(),
          
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 255, 102, 0)))),
      style: textStyle ?? const TextStyle(color: Colors.white),
    );
  }
}
