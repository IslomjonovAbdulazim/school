import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds/models/post_model.dart';
import 'package:ds/models/science_model.dart';
import 'package:ds/pages/teacher/system/inner/posts/posts_vm.dart';
import 'package:ds/pages/teacher/system/inner/posts/view/make_post.dart';
import 'package:ds/services/fb_firestore_service.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../services/fb_auth_service.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/format.dart';
import '../../../../../utils/lan.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/titles.dart';

class TPostsPage extends StatelessWidget {
  final ScienceModel science;

  const TPostsPage({super.key, required this.science});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => TPostsVM(null)),
      child: Consumer<TPostsVM>(
        builder: (context, TPostsVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.myPosts),
                style: s.t(
                  color: c.c1,
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
            ),
            body: SafeArea(
              child: FirestoreListView<PostModel>(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                pageSize: 10,
                query: fb.schoolPosts(auth.id),
                itemBuilder: ((context, doc) {
                  _AppValueNotifier appValueNotifier = _AppValueNotifier();
                  final PostModel post = doc.data();
                  return ValueListenableBuilder(
                      valueListenable: appValueNotifier.valueNotifier,
                      builder: (context, value, child) {
                        return Stack(
                          children: [
                            Container(
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: AspectRatio(
                                      aspectRatio: post.maxRatio,
                                      child: PageView(
                                        controller: PageController(),
                                        onPageChanged: (int index) {
                                          // vm.change(post, index);
                                          appValueNotifier
                                              .incrementNotifier(index);
                                        },
                                        children: post.body.map(
                                          (e) {
                                            return CachedNetworkImage(
                                              imageUrl: e.path,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child: AspectRatio(
                                                  aspectRatio: (post.body.first
                                                              .width ??
                                                          16) /
                                                      (post.body.first.height ??
                                                          9),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            );
                                          },
                                        ).toList(),
                                      ),
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
                                          duration:
                                              const Duration(milliseconds: 500),
                                          width: value == index ? 30 : 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                  SizedBox(
                                      height: post.science != null ? 10 : 0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        format.all(post.time),
                                        style: s.t(
                                          color: c.c3,
                                          size: 14,
                                          weight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: c.c2.withOpacity(.7),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => TMakePost(
                                          post: post, science: science.id,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: c.c3,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                }),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: c.c3,
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return TMakePost(science: science.id);
                    }),
                  ),
                );
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

class _AppValueNotifier {
  ValueNotifier valueNotifier = ValueNotifier(0);

  void incrementNotifier(int index) {
    valueNotifier.value = index;
  }
}
