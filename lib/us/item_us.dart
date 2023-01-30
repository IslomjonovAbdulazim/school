import 'package:flutter/cupertino.dart';

class ItemUS {
  late String title;
  String? image;
  late Widget page;
  IconData? icon;

  ItemUS({
    required this.title,
    required this.page,
    this.image,
    this.icon,
  });
}
