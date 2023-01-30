import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds/pages/guest/posts/posts_vm.dart';
import 'package:ds/pages/guest_web/posts/posts_vm.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/post_model.dart';
import '../../../services/fb_firestore_service.dart';
import '../../../utils/colors.dart';
import '../../../utils/format.dart';
import '../../../utils/lan.dart';
import '../../../utils/styles.dart';
import '../../../utils/titles.dart';

class GWPostsPage extends StatelessWidget {
  const GWPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GWPostsVM>(
      create: (_) => GWPostsVM(),
      child: Consumer<GWPostsVM>(
        builder: (context, GWPostsVM vm, _) {
          return FirestoreListView<PostModel>(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            pageSize: 3,
            query: fb.schoolPosts(),
            itemBuilder: ((context, doc) {
              final PostModel post = doc.data();
              _AppValueNotifier appValueNotifier = _AppValueNotifier();
              return ValueListenableBuilder(
                valueListenable: appValueNotifier.valueNotifier,
                builder: (context, value, child) {
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: c.c2,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: c.c5,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: post.maxRatio,
                            child: PageView(
                              physics: const BouncingScrollPhysics(),
                              controller: PageController(),
                              onPageChanged: appValueNotifier.incrementNotifier,
                              children: post.body.map(
                                (e) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: NetworkImage(e.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              post.body.length,
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
                          Text(
                            post.title,
                            style: s.t(
                              color: c.c3,
                              size: 20,
                              weight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            post.content,
                            style: s.t(
                              color: c.c3,
                              size: 15,
                              weight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: post.science != null ? 10 : 0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                format.all(post.time),
                                style: s.t(
                                  color: c.c3,
                                  size: 15,
                                  weight: FontWeight.w300,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: c.c1,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  post.science != null
                                      ? post.science!
                                      : lan(t.director),
                                  style: s.t(
                                    color: c.c3,
                                    size: 15,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
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
