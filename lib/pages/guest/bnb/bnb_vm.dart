import 'package:ds/pages/guest/employer/employer_page.dart';
import 'package:ds/pages/guest/posts/posts_page.dart';
import 'package:ds/pages/guest/proud/proud_page.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../../../utils/titles.dart';
import '../school/school_page.dart';
import '../settings/settings_page.dart';

class GBNBVM extends ChangeNotifier {
  int currentIndex = 0;
  late BuildContext context;
  GlobalKey<CurvedNavigationBarState> bnbKey = GlobalKey();

  GBNBVM(this.context);

  Widget get currentBody => [
        const GPostsPage(),
        const GSchoolPage(),
        const GProudPage(),
        const GEmployerPage(),
        const GSettingsPage(),
      ][currentIndex];

  Widget get currentFAB => [
        const SizedBox.shrink(),
        const SizedBox.shrink(),
        const SizedBox.shrink(),
        const SizedBox.shrink(),
        const SizedBox.shrink(),
      ][currentIndex];

  AppBar get currentAppBar => [
        AppBar(
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
        AppBar(
          backgroundColor: c.c3,
          title: Text(
            lan(t.school),
            style: s.t(
              color: c.c1,
              size: 20,
              weight: FontWeight.w700,
            ),
          ),
        ),
        AppBar(
          backgroundColor: c.c3,
          title: Text(
            lan(t.ourPride),
            style: s.t(
              color: c.c1,
              size: 20,
              weight: FontWeight.w700,
            ),
          ),
        ),
        AppBar(
          backgroundColor: c.c3,
          title: Text(
            lan(t.teachers),
            style: s.t(
              color: c.c1,
              size: 20,
              weight: FontWeight.w700,
            ),
          ),
        ),
        AppBar(
          backgroundColor: c.c3,
          title: Text(
            lan(t.settings),
            style: s.t(
              color: c.c1,
              size: 20,
              weight: FontWeight.w700,
            ),
          ),
        ),
      ][currentIndex];

  void changeCurrentIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
