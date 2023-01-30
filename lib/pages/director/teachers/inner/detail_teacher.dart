import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds/models/teacher_model.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/format.dart';
import '../../../../utils/styles.dart';
import '../../../../utils/titles.dart';

class DetailTeacherPage extends StatelessWidget {
  final DetailTeacherModel teacher;
  final String science;

  const DetailTeacherPage({
    Key? key,
    required this.teacher,
    required this.science,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c.c1,
      appBar: AppBar(
        backgroundColor: c.c3,
        title: Text(
          lan(t.teacher),
          style: s.t(
            color: c.c1,
            size: 20,
            weight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        children: [
          teacher.avatar != null
              ? Container(
                  height: 200,
                  width: 200,
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    color: c.c2,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        teacher.avatar!.path,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(color: c.c3),
          ),
          Text(
            lan(t.fullname),
            style: s.t(
              color: c.c3,
              size: 15,
              weight: FontWeight.w500,
            ),
          ),
          Text(
            teacher.fullname,
            style: s.t(
              size: 20,
              weight: FontWeight.w600,
              color: c.c3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(color: c.c3),
          ),
          Text(
            lan(t.bio),
            style: s.t(
              color: c.c3,
              size: 15,
              weight: FontWeight.w500,
            ),
          ),
          Text(
            teacher.bio!,
            style: s.t(
              size: 20,
              weight: FontWeight.w600,
              color: c.c3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(color: c.c3),
          ),
          Text(
            lan(t.science),
            style: s.t(
              color: c.c3,
              size: 15,
              weight: FontWeight.w500,
            ),
          ),
          Text(
            science,
            style: s.t(
              size: 20,
              weight: FontWeight.w600,
              color: c.c3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(color: c.c3),
          ),
          Text(
            lan(t.tels),
            style: s.t(
              color: c.c3,
              size: 15,
              weight: FontWeight.w500,
            ),
          ),
          ...teacher.tel.map(
            (e) => Text(
              e,
              style: s.t(
                size: 20,
                weight: FontWeight.w600,
                color: c.c3,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(color: c.c3),
          ),
          Text(
            lan(t.joinedTime),
            style: s.t(
              color: c.c3,
              size: 15,
              weight: FontWeight.w500,
            ),
          ),
          Text(
            '${format.all(teacher.time)}   ${format.formatTime2(teacher.time)}',
            style: s.t(
              size: 20,
              weight: FontWeight.w600,
              color: c.c3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(color: c.c3),
          ),
        ],
      ),
    );
  }
}
