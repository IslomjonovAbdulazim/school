import 'package:ds/pages/director/system/inner/sciences/sciences_page.dart';
import 'package:ds/pages/director/system/inner/call_schedule/call_schedule_page.dart';
import 'package:ds/pages/director/system/inner/reception_time/reception_time_page.dart';
import 'package:ds/pages/director/system/inner/school_bio/school_bio_page.dart';
import 'package:ds/pages/director/system/inner/school_posts/school_posts_page.dart';
import 'package:ds/us/item_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/foundation.dart';
import '../../../utils/titles.dart';
import 'inner/statute/statute_page.dart';

class DSystemVM extends ChangeNotifier {
  List<ItemUS> items = [];

  bool isGrid = false;

  DSystemVM() {
    init();
  }

  void init() async {
    items = [
      ItemUS(
        title: lan(t.sciences),
        page: const DSciencesPage(),
      ),
      ItemUS(
        title: lan(t.statute),
        page: const DStatutePage(),
      ),
      ItemUS(
        title: lan(t.schoolPosts),
        page: const DSchoolPostsPage(),
      ),
      ItemUS(
        title: lan(t.schoolBio),
        page: const DSchoolBioPage(),
      ),
      ItemUS(
        title: lan(t.callSchedule),
        page: const DCallSchedulePage(),
      ),
      ItemUS(
        title: lan(t.receptionTime),
        page: const DReceptionTimePage(),
      ),
      // ItemUS(
      //   title: lan(t.structure),
      //   page: const DStructurePage(),
      // ),
    ];
  }
}
