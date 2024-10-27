import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextFormField OperatorIdField(TextEditingController operatorIdController) {
  return TextFormField(
    controller: operatorIdController,
    validator: (value) {
      if (value == null || value.isEmpty || value.length < 7) {
        return 'Please enter valid ID';
      }
      return null;
    },
    decoration: InputDecoration(
      fillColor: Colors.teal[100],
      filled: true,
      suffixIcon: const Icon(Icons.person),
      labelText: "Operator ID",
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