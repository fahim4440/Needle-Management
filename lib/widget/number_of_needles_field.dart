import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextFormField NumberOfNeedlesField(TextEditingController numOfNeedlesController) {
  return TextFormField(
    controller: numOfNeedlesController,
    validator: (value) {
      if (value == null || value.isEmpty || int.parse(value) < 1) {
        return 'Please valid number';
      }
      return null;
    },
    decoration: InputDecoration(
      fillColor: Colors.teal[100],
      filled: true,
      suffixIcon: const Icon(Icons.pin),
      labelText: "Number of Needles",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    keyboardType: TextInputType.number,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
    ],
  );
}