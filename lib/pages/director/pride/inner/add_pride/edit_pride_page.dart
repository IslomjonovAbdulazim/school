import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds/models/pride_model.dart';
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

class EditPridePage extends StatelessWidget {
  final PrideModel pride;

  const EditPridePage({
    Key? key,
    required this.pride,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<AddPrideVM>(
      create: (_) => AddPrideVM(pride),
      child: Consumer<AddPrideVM>(
        builder: (context, AddPrideVM vm, _) {
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
                      AspectRatio(
                        aspectRatio: (vm.width ?? 16) / (vm.height ?? 9),
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          onPageChanged: ((value) {
                            vm.initRation(value);
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
                            vm.updatePride(pride.id).then((value) {
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
