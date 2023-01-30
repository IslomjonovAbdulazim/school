import 'dart:ui';

class ButtonUS {
  late String title;
  late VoidCallback? onTap;
  Size? size;
  Color? color;

  ButtonUS({
    required this.title,
    this.size,
    this.color,
    required this.onTap,
  });
}
