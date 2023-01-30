import 'package:flutter/material.dart';

import '../us/button_us.dart';
import '../utils/dimensions.dart';
import '../utils/styles.dart';

class ElevatedButtonC extends StatelessWidget {
  final ButtonUS us;

  const ElevatedButtonC({
    Key? key,
    required this.us,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: us.onTap,
      style: s.b(
        size: Size(us.size?.width ?? size.width, us.size?.height ?? 55),
        color: us.color,
      ),
      child: Text(
        us.title,
        style: s.t(
          weight: FontWeight.w600,
          size: d.t2,
        ),
      ),
    );
  }
}
