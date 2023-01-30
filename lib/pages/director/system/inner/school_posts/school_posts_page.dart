import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds/models/post_model.dart';
import 'package:ds/pages/director/system/inner/school_posts/school_posts_vm.dart';
import 'package:ds/pages/director/system/inner/school_posts/view/edit_post.dart';
import 'package:ds/pages/director/system/inner/school_posts/view/make_post.dart';
import 'package:ds/services/fb_auth_service.dart';
import 'package:ds/services/fb_firestore_service.dart';
import 'package:ds/utils/lan.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/format.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/titles.dart';

class DSchoolPostsPage extends StatelessWidget {
  const DSchoolPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => DSchoolPostsVM()),
      child: Consumer<DSchoolPostsVM>(
        builder: (context, DSchoolPostsVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.schoolPosts),
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
                  final PostModel post = doc.data();
                  final nf = _AppValueNotifier();
                  return ValueListenableBuilder(
                    valueListenable: nf.valueNotifier,
                    builder: (BuildContext context, value, Widget? child) {
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: AspectRatio(
                                    aspectRatio: post.maxRatio,
                                    child: PageView(
                                      controller: PageController(),
                                      onPageChanged: (int index) {
                                        nf.incrementNotifier(index);
                                        // vm.change(post, index);
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
                                                aspectRatio: (post
                                                            .body.first.width ??
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    post.body.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        width: nf.valueNotifier.value == index
                                            ? 30
                                            : 10,
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
                                const SizedBox(height: 10),
                                Text(
                                  format.all(post.time),
                                  style: s.t(
                                    color: c.c3,
                                    size: 15,
                                    weight: FontWeight.w300,
                                  ),
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
                                      builder: (_) => DSchoolEditPost(
                                        pride: post,
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
                    },
                  );
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
                      return const DSchoolMakePost();
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
