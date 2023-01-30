import 'package:ds/models/science_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';

class SciencesItem extends StatelessWidget {
  final ScienceModel science;
  final VoidCallback onTap;
  const SciencesItem({
    super.key,
    required this.science,
    required this.onTap,
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
        onTap: onTap,
        title: Text(
          science.name,
          style: s.t(
            color: c.c3,
            size: 20,
            weight: FontWeight.w700,
          ),
        ),
        trailing: Icon(
          CupertinoIcons.chevron_right,
          color: c.c3,
          size: 27,
        ),
      ),
    );
  }
}
