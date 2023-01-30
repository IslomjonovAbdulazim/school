import 'package:ds/models/statutes_model.dart';
import 'package:ds/pages/director/system/inner/statute/statute_vm.dart';
import 'package:ds/pages/director/system/inner/statute/view/add_chapter.dart';
import 'package:ds/pages/director/system/inner/statute/view/add_statute.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../../utils/titles.dart';

class ChapterDetail extends StatefulWidget {
  final List<StatuteModel> statutes;
  final StatuteModel statute;

  const ChapterDetail({
    super.key,
    required this.statutes,
    required this.statute,
  });

  @override
  State<ChapterDetail> createState() => _ChapterDetailState();
}

class _ChapterDetailState extends State<ChapterDetail> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<DStatuteVM>(
      create: (_) => DStatuteVM(null),
      child: Consumer<DStatuteVM>(
        builder: (context, DStatuteVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.statutes),
                style: s.t(
                  color: c.c1,
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    vm.deleteChapter(widget.statutes, widget.statute).then(
                      (value) {
                        Navigator.pop(context);
                      },
                    );
                  },
                  icon: Icon(
                    CupertinoIcons.delete,
                    color: c.c8,
                    size: 30,
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                IgnorePointer(
                  ignoring: vm.isLoading,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          ...widget.statute.title
                              .split(' ')
                              .map(
                                (e) => Text(
                                  '$e ',
                                  style: s.t(
                                    color: c.c3,
                                    size: 22.5,
                                    weight: FontWeight.w900,
                                  ),
                                ),
                              )
                              .toList(),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) {
                                    return AddChapter(
                                      statutes: widget.statutes,
                                      statute: widget.statute,
                                    );
                                  }),
                                ),
                              ).then((value) {
                                setState(() {});
                              });
                            }),
                            child: Icon(
                              Icons.edit,
                              color: c.c3,
                              size: 27,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Divider(
                          color: c.c3,
                          thickness: 2,
                        ),
                      ),
                      ...List.generate(widget.statute.content.length, (index) {
                        final e = widget.statute.content[index];
                        final b = '${index + 1}. $e';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              alignment: WrapAlignment.start,
                              children: [
                                ...b
                                    .split(' ')
                                    .map(
                                      (e) => Text(
                                        '$e ',
                                        style: s.t(
                                          color: c.c3,
                                          size: 17.5,
                                          weight: FontWeight.w700,
                                        ),
                                      ),
                                    )
                                    .toList(),
                                const SizedBox(width: 10),
                                InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) {
                                          return AddStatute(
                                            statute: widget.statute,
                                            title: e,
                                          );
                                        }),
                                      ),
                                    ).then((value) {
                                      setState(() {});
                                    });
                                  }),
                                  child: Icon(
                                    Icons.edit,
                                    color: c.c3,
                                    size: 27,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: c.c3,
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                vm.isLoading
                    ? Container(
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
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: c.c3,
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return AddStatute(
                        statute: widget.statute,
                      );
                    }),
                  ),
                ).then((value) {
                  setState(() {});
                });
              }),
              child: Icon(
                CupertinoIcons.add,
                color: c.c1,
                size: 30,
              ),
            ),
          );
        },
      ),
    );
  }
}
