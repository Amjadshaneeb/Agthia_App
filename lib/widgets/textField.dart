import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  const Mytextfield({super.key, required this.hinttext, required this.icon, required this.obscure});
  final String hinttext;
  final Icon icon;
  final bool obscure ;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      ),
    );
  }
}
