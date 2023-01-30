import 'package:ds/pages/director/system/inner/statute/view/add_chapter.dart';
import 'package:ds/pages/director/system/inner/statute/view/chapter_detail.dart';
import 'package:ds/pages/director/system/inner/statute/view/chapter_item.dart';
import 'package:ds/pages/guest/school/inner/statute/view/chapter_detail.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../../../../models/statutes_model.dart';
import '../../../../../services/fb_firestore_service.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/titles.dart';
import 'statute_vm.dart';

class GWStatutePage extends StatefulWidget {
  const GWStatutePage({super.key});

  @override
  State<GWStatutePage> createState() => _GStatutePageState();
}

class _GStatutePageState extends State<GWStatutePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => GWStatuteVM(null),
      child: Consumer<GWStatuteVM>(
        builder: (context, GWStatuteVM vm, _) {
          return FutureBuilder<List<StatuteModel>>(
            future: fb.getAllStatutes(),
            builder: (context, AsyncSnapshot<List<StatuteModel>> snap) {
              if (snap.hasData) {
                snap.data!.sort(
                  ((a, b) => a.time.compareTo(b.time)),
                );
              }
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: c.c3,
                  title: Text(
                    lan(t.statuteChapters),
                    style: s.t(
                      color: c.c1,
                      size: 20,
                      weight: FontWeight.w700,
                    ),
                  ),
                ),
                body: snap.hasData
                    ? AnimationLimiter(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 10,
                          ),
                          itemCount: snap.data!.length,
                          itemBuilder: ((context, index) {
                            final statute = snap.data![index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: ChapterItem(
                                    index: index,
                                    statute: statute,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => GChapterDetail(
                                                statutes: snap.data!,
                                                statute: statute,
                                              )),
                                        ),
                                      ).then((value) {
                                        setState(() {});
                                      });
                                    },
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                    : Container(
                        height: size.height,
                        width: size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.3),
                        ),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator(
                            color: c.c1,
                            strokeWidth: 7,
                          ),
                        ),
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
