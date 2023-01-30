import 'package:ds/us/item_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/foundation.dart';
import '../../../utils/titles.dart';
import 'inner/call_schedule/call_schedule_page.dart';
import 'inner/reception_time/reception_time_page.dart';
import 'inner/school_bio/school_bio_page.dart';
import 'inner/statute/statute_page.dart';

class GWSchoolVM extends ChangeNotifier {
  List<ItemUS> items = [];

  bool isGrid = false;

  GWSchoolVM() {
    init();
  }

  void init() async {
    items = [
      ItemUS(
        title: lan(t.statute),
        page: const GWStatutePage(),
      ),
      ItemUS(
        title: lan(t.schoolBio),
        page: const GWSchoolBioPage(),
      ),
      ItemUS(
        title: lan(t.callSchedule),
        page: const GWCallSchedulePage(),
      ),
      ItemUS(
        title: lan(t.receptionTime),
        page: const GWReceptionTimePage(),
      ),
      // ItemUS(
      //   title: lan(t.structure),
      //   page: const DStructurePage(),
      // ),
    ];
  }
}
