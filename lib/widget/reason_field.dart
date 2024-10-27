import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

TextFormField ReasonField(TextEditingController reasonController) {
  return TextFormField(
    controller: reasonController,
    validator: (value) {
      if (value == null || value.isEmpty || value.length < 5) {
        return 'Please valid reason';
      }
      return null;
    },
    decoration: InputDecoration(
      fillColor: Colors.teal[100],
      filled: true,
      suffixIcon: const Icon(Icons.file_present),
      labelText: "Reason",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    keyboardType: TextInputType.text,
  );
}