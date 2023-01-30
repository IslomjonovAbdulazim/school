import 'package:ds/pages/teacher/system/inner/article/all_articles.dart';
import 'package:ds/pages/teacher/system/inner/posts/posts_page.dart';
import 'package:ds/pages/teacher/system/inner/science_posts/science_posts_page.dart';
import 'package:ds/services/fb_firestore_service.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';

import '../../../models/science_model.dart';
import '../../../us/item_us.dart';
import '../../../utils/titles.dart';
import 'inner/article/article_page.dart';
import 'inner/call_schedule/call_schedule_page.dart';
import 'inner/reception_time/reception_time_page.dart';
import 'inner/school_bio/school_bio_page.dart';
import 'inner/statute/statute_page.dart';

class TSystemVM extends ChangeNotifier {
  List<ItemUS> items = [];
  bool isLoading = false;
  ScienceModel? science;

  TSystemVM() {
    init();
  }

  void init() async {
    _update();
    science = await fb.getScience();
    if (science != null) {
      items = [
        ItemUS(
          title: science?.name ?? '',
          page: SciencePostsPage(science: science!),
        ),
        ItemUS(
          title: lan(t.myPosts),
          page: TPostsPage(science: science!),
        ),
        ItemUS(
          title: lan(t.article),
          page: const TAllArticles(),
        ),
        ItemUS(
          title: lan(t.statute),
          page: const TStatutePage(),
        ),
        ItemUS(
          title: lan(t.schoolBio),
          page: const TSchoolBioPage(),
        ),
        ItemUS(
          title: lan(t.callSchedule),
          page: const TCallSchedulePage(),
        ),
        ItemUS(
          title: lan(t.receptionTime),
          page: const TReceptionTimePage(),
        ),
      ];
    }
    _update();
  }

  void _update() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
