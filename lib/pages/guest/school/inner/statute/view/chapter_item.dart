import 'package:ds/models/statutes_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';

class ChapterItem extends StatelessWidget {
  final StatuteModel statute;
  final int index;
  final VoidCallback onTap;
  const ChapterItem({
    super.key,
    required this.statute,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: c.c2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        minLeadingWidth: 0,
        leading: Text(
          (index + 1).toString(),
          style: s.t(
            color: c.c3,
            size: 20,
            weight: FontWeight.w900,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          statute.title,
          style: s.t(
            color: c.c3,
            size: 17.5,
            weight: FontWeight.w700,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(
          CupertinoIcons.right_chevron,
          size: 27,
        ),
      ),
    );
  }
}
