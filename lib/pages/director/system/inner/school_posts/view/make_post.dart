import 'dart:io';

import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/custom/text_field_c.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../../utils/titles.dart';
import '../school_posts_vm.dart';

class DSchoolMakePost extends StatelessWidget {
  const DSchoolMakePost({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _AppValueNotifier appValueNotifier = _AppValueNotifier();
    return ChangeNotifierProvider<DSchoolPostsVM>(
      create: ((context) => DSchoolPostsVM()),
      child: Consumer<DSchoolPostsVM>(
        builder: (context, DSchoolPostsVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.makePost),
                style: s.t(
                  color: c.c1,
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
            ),
            body: ValueListenableBuilder(
              valueListenable: _AppValueNotifier().valueNotifier,
              builder: (BuildContext context, value, Widget? child) {
                return Stack(
                  children: [
                    IgnorePointer(
                      ignoring: vm.isLoading,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        children: [
                          AspectRatio(
                            aspectRatio: (vm.width ?? 16) / (vm.height ?? 9),
                            child: PageView(
                              physics: const BouncingScrollPhysics(),
                              onPageChanged: ((value) {
                                vm.initRation(value);
                                appValueNotifier.incrementNotifier(value);
                              }),
                              children: vm.body.map(
                                (e) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(e.path),
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              vm.body.length,
                                  (index) => Padding(
                                padding: const EdgeInsets.all(2),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  width: appValueNotifier.valueNotifier.value == index ? 30 : 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: c.c3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButtonC(
                            us: ButtonUS(
                              color: c.c6,
                              title: lan(t.pickImage),
                              onTap: (() {
                                vm.pickImage();
                              }),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFieldC(us: vm.title),
                          const SizedBox(height: 10),
                          TextFieldC(us: vm.content),
                          const SizedBox(height: 30),
                          ElevatedButtonC(
                            us: ButtonUS(
                              color: c.c6,
                              title: lan(t.makePost),
                              onTap: (() {
                                vm.uploadPost().then((value) {
                                  Navigator.pop(context);
                                });
                              }),
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
                );
              },
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
