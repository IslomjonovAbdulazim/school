import 'package:flutter/material.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';

class StatuteItem extends StatelessWidget {
  final String title;
  const StatuteItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: c.c2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          title,
          style: s.t(
            color: c.c3,
            size: 20,
            weight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
