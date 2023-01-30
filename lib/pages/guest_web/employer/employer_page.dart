import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds/pages/guest/employer/detail_employer.dart';
import 'package:ds/pages/guest/employer/employer_vm.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/science_model.dart';
import '../../../models/teacher_model.dart';
import '../../../services/fb_firestore_service.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import 'detail_employer.dart';
import 'employer_vm.dart';

class GWEmployerPage extends StatelessWidget {
  const GWEmployerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GWEmployerVM>(
      create: (_) => GWEmployerVM(),
      child: Consumer<GWEmployerVM>(
        builder: (context, GWEmployerVM vm, _) {
          return FirestoreListView<TeacherModel>(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            pageSize: 15,
            query: fb.teachers(),
            itemBuilder: ((context, doc) {
              final TeacherModel teacher = doc.data();
              String science = vm.sciences
                  .firstWhere(
                    (element) => element.id == teacher.detail.science,
                    orElse: () => ScienceModel(
                      name: '...',
                      des: '',
                      id: '',
                    ),
                  )
                  .name;
              return Align(
                alignment: Alignment.center,
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 777,
                  ),
                  child: Card(
                    color: c.c2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GWDetailEmployerPage(
                              teacher: teacher.detail,
                              science: science,
                            ),
                          ),
                        );
                      },
                      leading: teacher.detail.avatar != null
                          ? Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: c.c3,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    teacher.detail.avatar!.path,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : null,
                      title: Text(
                        teacher.detail.fullname,
                        style: s.t(
                          color: c.c3,
                          size: 20,
                          weight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        science,
                        style: s.t(
                          color: c.c3,
                        ),
                      ),
                      trailing: Icon(
                        CupertinoIcons.chevron_right,
                        color: c.c3,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
