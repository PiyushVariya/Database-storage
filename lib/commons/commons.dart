import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:database/utils/colors.dart';

final userController = TextEditingController();
final emailController = TextEditingController();
final imageController = TextEditingController();
final passwordController = TextEditingController();
final ageController = TextEditingController();
final cityController = TextEditingController();

// Widget customeTextField({
//   required String hintText,
//   required TextEditingController? controller,
//   required String? Function(String?)? validator,
// }) {
//   return
// }

class CustomeTextField extends StatefulWidget {
  const CustomeTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<CustomeTextField> createState() => _CustomeTextFieldState();
}

class _CustomeTextFieldState extends State<CustomeTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget
          .validator, // (value) => value!.isEmpty ? 'password not vaild' : null,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Clr.grey),
        contentPadding: const EdgeInsets.only(left: 40.0),
        filled: true,
        hintText: widget.hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(50.0),
            right: Radius.circular(50.0),
          ),
        ),
      ),
    );
  }
}
