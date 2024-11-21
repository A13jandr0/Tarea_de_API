import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String value;
  final String label;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;

  const CustomDropdown({
    Key? key,
    required this.value,
    required this.label,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF34495E),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFD5D8DC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF2980B9), width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFFF4F6F7),
      ),
      dropdownColor: Colors.white,
      style: const TextStyle(
        color: Color(0xFF2C3E50),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Color(0xFF2980B9),
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}
