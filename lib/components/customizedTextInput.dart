import 'package:flutter/material.dart';
import 'package:patient_care_app/historyReview.dart';
import 'dart:convert';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final Function(String)? onChanged;

  CustomTextField({
    required this.labelText,
    this.onChanged,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: Colors.blue,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red, // set the border color to red
          ),
        ),
      ),
      onChanged: (value) {
        setState(() {
          _value = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }
}
