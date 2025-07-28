import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final bool? readOnly;
  const CustomInput({
    super.key,
    required this.controller,
     this.readOnly = false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly!,
      controller: controller,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        constraints: BoxConstraints.expand(height: 45),
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
