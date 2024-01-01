import 'package:flutter/material.dart';

TextField ReusableTextField(String? text, bool isPasswordType,
    TextEditingController? controller, String hintText) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      labelText: text,
      hintText: hintText,
      hintStyle: TextStyle(
        color: Color.fromRGBO(36, 20, 104, 0.6),
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
