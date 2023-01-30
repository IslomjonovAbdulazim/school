import 'package:ds/pages/teacher/account/account_page.dart';
import 'package:ds/pages/teacher/news/news_page.dart';
import 'package:ds/pages/teacher/system/system_page.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../../../utils/titles.dart';

class DBNBVM extends ChangeNotifier {
  int currentIndex = 0;
  late BuildContext context;
  GlobalKey<CurvedNavigationBarState> bnbKey = GlobalKey();

  DBNBVM(this.context);

  Widget get currentBody => [
        const TNewsPage(),
        const TSystemPage(),
        // const TArticlePage(),
        const TAccountPage(),
      ][currentIndex];

  Widget get currentFAB => [
        const SizedBox.shrink(),
        const SizedBox.shrink(),
        // const SizedBox.shrink(),
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
            lan(t.system),
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
            lan(t.profile),
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
