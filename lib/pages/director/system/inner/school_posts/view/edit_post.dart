import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/custom/text_field_c.dart';
import 'package:ds/models/post_model.dart';
import 'package:ds/pages/director/system/inner/school_posts/view/edit_post_vm.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../../utils/titles.dart';
import '../school_posts_vm.dart';

class DSchoolEditPost extends StatelessWidget {
  final PostModel pride;

  const DSchoolEditPost({Key? key, required this.pride}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final nf = _AppValueNotifier();
    return ChangeNotifierProvider<DSchoolEditPostVM>(
      create: (_) => DSchoolEditPostVM(pride),
      child: Consumer<DSchoolEditPostVM>(
        builder: (context, DSchoolEditPostVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.editSchoolPride),
                style: s.t(
                  color: c.c1,
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
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
                    children: [
                      ValueListenableBuilder(
                        valueListenable: nf.valueNotifier,
                        builder: (BuildContext context, value, Widget? child) {
                          return AspectRatio(
                            aspectRatio: (vm.width ?? 16) / (vm.height ?? 9),
                            child: PageView(
                              physics: const BouncingScrollPhysics(),
                              onPageChanged: ((value) {
                                vm.initRation(value);
                                nf.incrementNotifier(value);
                              }),
                              children: vm.media.map(
                                (e) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: e.isUploaded != true
                                            ? FileImage(
                                                File(e.path),
                                              )
                                            : CachedNetworkImageProvider(e.path)
                                                as ImageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            vm.media.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(2),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                width:
                                    index == nf.valueNotifier.value ? 30 : 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: index == nf.valueNotifier.value
                                      ? c.c3
                                      : c.c2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 10),
                      // ElevatedButtonC(
                      //   us: ButtonUS(
                      //     color: c.c6,
                      //     title: lan(t.pickImage),
                      //     onTap: (() {
                      //       vm.pickImage();
                      //     }),
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      TextFieldC(
                        us: vm.title,
                      ),
                      const SizedBox(height: 10),
                      TextFieldC(
                        us: vm.des,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButtonC(
                        us: ButtonUS(
                          color: c.c6,
                          title: lan(t.update),
                          onTap: () {
                            vm.updatePost(pride.id).then((value) {
                              if (value) {
                                Navigator.pop(context);
                              }
                            });
                          },
                        ),
                      ),
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
          );
        },
      ),
    );
  }
}

class _AppValueNotifier {
  ValueNotifier valueNotifier = ValueNotifier(0);

  void incrementNotifier(int index) {
    valueNotifier.value = index;
  }
}
