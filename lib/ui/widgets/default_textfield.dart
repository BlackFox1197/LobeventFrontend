import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final TextInputType type;
  final String hintText;
  final bool obscure;
  final TextEditingController controller;

  DefaultTextField(this.type, this.hintText, this.obscure, this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      obscureText: obscure,
      autofocus: false,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      ),
    );
  }
}
