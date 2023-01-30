import 'package:flutter/material.dart';
import '../us/text_field_us.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/styles.dart';
import '../utils/titles.dart';

class TextFieldC extends StatelessWidget {
  final TextFieldUS us;

  const TextFieldC({
    Key? key,
    required this.us,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      style: s.t(
        size: d.t3,
        weight: FontWeight.w600,
      ),
      maxLines: us.isMultiline ? null : 1,
      keyboardType: us.isMultiline ? TextInputType.multiline : null,
      validator: us.validator,
      controller: us.controller,
      onSaved: (a) {
        if (us.key?.currentState?.validate() == true) {
          us.key?.currentState?.save();
        }
      },
      cursorColor: c.c1,
      obscureText: us.isPassword,
      decoration: InputDecoration(
        hintText: us.title,
        hintStyle: s.t(
          size: d.t2,
          weight: FontWeight.w300,
        ),
        filled: true,
        fillColor: us.bg ?? c.c3,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
