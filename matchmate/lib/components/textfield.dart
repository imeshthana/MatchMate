import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:matchmate/components/constants.dart';

TextField ReusableTextField(String? text, bool isPasswordType,
    TextEditingController? controller, String hintText) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        // labelText: text,
        hintText: hintText,
        hintStyle: hintTextStyle,
        border: GradientOutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            gradient: gradient,
            width: 2.5)),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
