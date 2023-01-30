import 'package:flutter/cupertino.dart';

class TextFieldUS {
  late String title;
  late TextEditingController controller;
  late bool isPassword;
  GlobalKey<FormState>? key;
  String? Function(String?)? validator;
  Color? bg;
  late bool isMultiline;

  TextFieldUS({
    required this.controller,
    required this.title,
    this.isPassword = false,
    this.isMultiline = false,
    this.validator,
    this.key,
    this.bg,
  });
}
