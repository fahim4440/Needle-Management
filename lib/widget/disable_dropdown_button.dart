import 'package:flutter/material.dart';

DropdownButton DisableDropdownButton(BuildContext context, String value) {
  return DropdownButton(
    value: value,
    style: const TextStyle(color: Colors.black),
    items: [
      DropdownMenuItem(
        value: value,
        child: Text(value),
      )
    ],
    onChanged: null,
    dropdownColor: Colors.grey[300],
  );
}