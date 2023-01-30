import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds/pages/guest/school/inner/school_bio/school_bio_vm.dart';
import 'package:ds/utils/format.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/hints.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/titles.dart';
import 'school_bio_vm.dart';

class TSchoolBioPage extends StatelessWidget {
  const TSchoolBioPage({super.key});

  @override
  Widget build(BuildContext context) {
    _AppValueNotifier appValueNotifier = _AppValueNotifier();
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<TSchoolBioVM>(
      create: (context) => TSchoolBioVM(),
      child: Consumer<TSchoolBioVM>(
        builder: (context, TSchoolBioVM vm, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.schoolBio),
              ),
            ),
            body: ValueListenableBuilder(
              valueListenable: appValueNotifier.valueNotifier,
              builder: (context, value, child) {
                return SafeArea(
                  child: Stack(
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
                            Text(
                              lan(t.images),
                              style: s.t(
                                color: c.c3,
                                size: 15,
                                weight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: AspectRatio(
                                aspectRatio: (vm.width ?? 16) / (vm.height ?? 9),
                                child: PageView(
                                  onPageChanged: (int index) {
                                    vm.change(index);
                                    appValueNotifier.incrementNotifier(index);
                                  },
                                  children: vm.images.map(
                                    (e) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: e.isUploaded == false
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
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                vm.images.length,
                                    (index) => Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    width: value == index ? 30 : 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: c.c3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Divider(color: c.c3),
                            Text(
                              lan(t.tels),
                              style: s.t(
                                color: c.c3,
                                size: 15,
                                weight: FontWeight.w500,
                              ),
                            ),
                            ...vm.tel.map(
                              (e) => TextField(
                                readOnly: true,
                                autocorrect: false,
                                cursorColor: c.c3,
                                controller: e,
                                style: s.t(
                                  color: c.c3,
                                  weight: FontWeight.w500,
                                  size: 20,
                                ),
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  format.uz(),
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: lan(h.phoneNumber),
                                  hintStyle: s.t(
                                    color: c.c3,
                                    size: 17,
                                    weight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            Divider(color: c.c3),
                            Text(
                              lan(t.location),
                              style: s.t(
                                color: c.c3,
                                size: 15,
                                weight: FontWeight.w500,
                              ),
                            ),
                            TextField(
                              readOnly: true,
                              cursorColor: c.c3,
                              controller: vm.location,
                              autocorrect: false,
                              style: s.t(
                                color: c.c3,
                                size: 20,
                                weight: FontWeight.w700,
                              ),
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: lan(h.location),
                                hintStyle: s.t(
                                  color: c.c3,
                                  size: 17,
                                  weight: FontWeight.w300,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                            Divider(color: c.c3),
                            Text(
                              lan(t.bio),
                              style: s.t(
                                color: c.c3,
                                size: 15,
                                weight: FontWeight.w500,
                              ),
                            ),
                            TextField(
                              cursorColor: c.c3,
                              controller: vm.des,
                              readOnly: true,
                              autocorrect: false,
                              style: s.t(
                                color: c.c3,
                                size: 20,
                                weight: FontWeight.w700,
                              ),
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: lan(h.bio),
                                hintStyle: s.t(
                                  color: c.c3,
                                  size: 17,
                                  weight: FontWeight.w300,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                            Divider(color: c.c3),
                            Text(
                              lan(t.statistics),
                              style: s.t(
                                color: c.c3,
                                size: 15,
                                weight: FontWeight.w500,
                              ),
                            ),
                            ...vm.statistics.keys.map(
                              (e) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextField(
                                      readOnly: true,
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      controller: e,
                                      cursorColor: c.c3,
                                      autocorrect: false,
                                      style: s.t(
                                        color: c.c3,
                                        size: 20,
                                        weight: FontWeight.w700,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: lan(h.name),
                                        hintStyle: s.t(
                                          color: c.c3,
                                          size: 17,
                                          weight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      readOnly: true,
                                      maxLines: null,
                                      cursorColor: c.c3,
                                      keyboardType: TextInputType.multiline,
                                      autocorrect: false,
                                      style: s.t(
                                        color: c.c3,
                                        size: 20,
                                        weight: FontWeight.w700,
                                      ),
                                      controller: vm.statistics[e]!,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: lan(h.value),
                                        hintStyle: s.t(
                                          color: c.c3,
                                          size: 17,
                                          weight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: c.c3),
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
              }
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