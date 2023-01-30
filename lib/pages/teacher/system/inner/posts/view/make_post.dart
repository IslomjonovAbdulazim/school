import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/custom/text_field_c.dart';
import 'package:ds/models/post_model.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../../utils/titles.dart';
import '../posts_vm.dart';

class TMakePost extends StatelessWidget {
  final String science;
  final PostModel? post;

  const TMakePost({
    super.key,
    required this.science,
    this.post,
  });

  @override
  Widget build(BuildContext context) {
    _AppValueNotifier appValueNotifier = _AppValueNotifier();
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<TPostsVM>(
      create: ((context) => TPostsVM(post)),
      child: Consumer<TPostsVM>(
        builder: (context, TPostsVM vm, _) {
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
              actions: [
                post != null
                    ? IconButton(
                        onPressed: () {
                          vm.deletePost(post!).then((value) {
                            if (value) {
                              Navigator.pop(context);
                            }
                          });
                        },
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: c.c8,
                          size: 30,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            body: Stack(
              children: [
                IgnorePointer(
                  ignoring: vm.isLoading,
                  child: ValueListenableBuilder(
                      valueListenable: appValueNotifier.valueNotifier,
                      builder: (context, value, child) {
                        return ListView(
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
                                    return Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: e.isUploaded == true
                                                  ? CachedNetworkImageProvider(
                                                      e.path) as ImageProvider
                                                  : FileImage(
                                                      File(e.path),
                                                    ),
                                              fit: BoxFit.contain,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () {
                                              vm.deleteImage(e);
                                              if (value != 0) {
                                                vm.initRation(value - 1);
                                                appValueNotifier
                                                    .incrementNotifier(
                                                        value - 1);
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                color: c.c3.withOpacity(.4),
                                                borderRadius:
                                                    BorderRadius.circular(120),
                                              ),
                                              child: Icon(
                                                CupertinoIcons.delete,
                                                color: c.c1,
                                                size: 27,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                vm.body.length,
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
                                  vm
                                      .uploadPost(science, post)
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                }),
                              ),
                            ),
                          ],
                        );
                      }),
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
