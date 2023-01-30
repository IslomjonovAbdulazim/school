import 'package:ds/models/science_model.dart';
import 'package:ds/pages/director/system/inner/sciences/cu_science_page.dart';
import 'package:ds/pages/director/system/inner/sciences/sciences_vm.dart';
import 'package:ds/pages/director/system/inner/sciences/view/sciences_item.dart';
import 'package:ds/utils/lan.dart';
import 'package:ds/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../../../services/fb_firestore_service.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/titles.dart';

class DSciencesPage extends StatefulWidget {
  const DSciencesPage({super.key});

  @override
  State<DSciencesPage> createState() => _DSciencesPageState();
}

class _DSciencesPageState extends State<DSciencesPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: ((context) => DSciencesVM(null)),
      child: Consumer<DSciencesVM>(
        builder: (context, DSciencesVM vm, _) {
          return FutureBuilder<List<ScienceModel>?>(
              future: fb.getAllSciences(),
              builder: (context, final snap) {
                return Scaffold(
                  backgroundColor: c.c1,
                  appBar: AppBar(
                    backgroundColor: c.c3,
                    title: Text(
                      lan(t.sciences),
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
                              final science = snap.data![index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: SciencesItem(
                                      science: science,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) =>
                                                CUSciencePage(
                                                  sciences: snap.data ?? [],
                                                  science: science,
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
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: c.c3,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => CUSciencePage(
                                sciences: snap.data!,
                              )),
                        ),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    child: Icon(
                      CupertinoIcons.add,
                      color: c.c1,
                      size: 30,
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
