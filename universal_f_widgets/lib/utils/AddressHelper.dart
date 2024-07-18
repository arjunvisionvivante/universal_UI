import 'package:flutter/material.dart';

phoneFieldDecoration(String labelText, String hintText) {
  return InputDecoration(
      labelText: labelText,

      // hintTextDirection: TextDirection.rtl,
      prefixIcon: Icon(Icons.phone),
      labelStyle: TextStyle(color: Colors.grey.shade300, fontSize: 14),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500),
          borderRadius: BorderRadius.circular(9)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red)),
      hintText: hintText,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 8, vertical: 18));
}