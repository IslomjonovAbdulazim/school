import 'package:ds/pages/director/account/account_page.dart';
import 'package:ds/pages/director/posts/posts_page.dart';
import 'package:ds/pages/director/system/system_page.dart';
import 'package:ds/pages/director/teachers/inner/add_teacher/add_teacher_page.dart';
import 'package:ds/pages/director/teachers/teachers_page.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../../../utils/titles.dart';
import '../pride/inner/add_pride/add_pride_page.dart';
import '../pride/pride_page.dart';

class DBNBVM extends ChangeNotifier {
  int currentIndex = 0;
  late BuildContext context;
  GlobalKey<CurvedNavigationBarState> bnbKey = GlobalKey();

  DBNBVM(this.context);

  Widget get currentBody => [
        const DPostsPage(),
        const DTeachersPage(),
        const PridePage(),
        const DSystemPage(),
        const DAccountPage(),
      ][currentIndex];

  Widget get currentFAB => [
        const SizedBox.shrink(),
        FloatingActionButton(
          backgroundColor: c.c3,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddTeacherPage(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: c.c1,
            size: 35,
          ),
        ),
        FloatingActionButton(
          backgroundColor: c.c3,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddPridePage(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: c.c1,
            size: 35,
          ),
        ),
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
