import 'dart:io';

import 'package:ds/pages/director/pride/inner/add_pride/add_pride_vm.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../custom/elevated_button_c.dart';
import '../../../../../custom/text_field_c.dart';
import '../../../../../us/button_us.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/titles.dart';

class AddPridePage extends StatelessWidget {
  const AddPridePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<AddPrideVM>(
      create: (_) => AddPrideVM(),
      child: Consumer<AddPrideVM>(
        builder: (context, AddPrideVM vm, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.newSchoolPride),
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
                      AspectRatio(
                        aspectRatio: (vm.width ?? 16) / (vm.height ?? 9),
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          onPageChanged: ((value) {
                            vm.initRation(value);
                          }),
                          children: vm.media.map(
                            (e) {
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(e.path),
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: c.c2.withOpacity(.5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        onPressed: vm.remove,
                                        icon: Icon(
                                          CupertinoIcons.xmark,
                                          color: c.c8,
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ).toList(),
                        ),
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
                                width: index == vm.current ? 30 : 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: index == vm.current ? c.c3 : c.c2,
                                ),
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
                      const SizedBox(height: 10),
                      TextFieldC(
                        us: vm.fullname,
                      ),
                      const SizedBox(height: 10),
                      TextFieldC(
                        us: vm.why,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButtonC(
                        us: ButtonUS(
                          color: c.c6,
                          title: lan(t.add),
                          onTap: () {
                            vm.uploadPost().then((value) {
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
