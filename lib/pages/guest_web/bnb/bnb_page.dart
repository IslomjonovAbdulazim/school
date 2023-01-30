import 'dart:io';

import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../../../utils/titles.dart';
import 'bnb_vm.dart';

class GWBNBPage extends StatelessWidget {
  const GWBNBPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GWBNBVM(context),
      child: Consumer<GWBNBVM>(
        builder: (context, GWBNBVM vm, _) {
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Scaffold(
              appBar: vm.currentAppBar,
              backgroundColor: c.c1,
              body: SafeArea(
                top: false,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    constraints.maxWidth > 600 && constraints.maxHeight > 500
                        ? NavigationRail(
                            selectedIndex: vm.currentIndex,
                            groupAlignment: -1,
                            indicatorColor: c.c2,
                            useIndicator: true,
                            backgroundColor: c.c1,
                            onDestinationSelected: vm.changeCurrentIndex,
                            labelType: NavigationRailLabelType.all,
                            destinations: <NavigationRailDestination>[
                              NavigationRailDestination(
                                icon: Icon(
                                  CupertinoIcons.news,
                                  size: 25,
                                  color: c.c5,
                                ),
                                selectedIcon: Icon(
                                  CupertinoIcons.news_solid,
                                  size: 30,
                                  color: c.c3,
                                ),
                                label: Text(
                                  lan(t.news),
                                  style: s.t(
                                    color: c.c3,
                                    size: 15,
                                  ),
                                ),
                              ),
                              NavigationRailDestination(
                                icon: Icon(
                                  Icons.home_outlined,
                                  size: 25,
                                  color: c.c5,
                                ),
                                selectedIcon: Icon(
                                  Icons.home,
                                  size: 30,
                                  color: c.c3,
                                ),
                                label: Text(
                                  lan(t.school),
                                  style: s.t(
                                    color: c.c3,
                                    size: 15,
                                  ),
                                ),
                              ),
                              NavigationRailDestination(
                                icon: Icon(
                                  CupertinoIcons.person_2,
                                  size: 25,
                                  color: c.c5,
                                ),
                                selectedIcon: Icon(
                                  CupertinoIcons.person_2_fill,
                                  size: 30,
                                  color: c.c3,
                                ),
                                label: Text(
                                  lan(t.ourPride),
                                  style: s.t(
                                    color: c.c3,
                                    size: 15,
                                  ),
                                ),
                              ),
                              NavigationRailDestination(
                                icon: Icon(
                                  CupertinoIcons.person_3,
                                  size: 25,
                                  color: c.c5,
                                ),
                                selectedIcon: Icon(
                                  CupertinoIcons.person_3_fill,
                                  size: 30,
                                  color: c.c3,
                                ),
                                label: Text(
                                  lan(t.teachers),
                                  style: s.t(
                                    color: c.c3,
                                    size: 15,
                                  ),
                                ),
                              ),
                              NavigationRailDestination(
                                icon: Icon(
                                  CupertinoIcons.settings,
                                  size: 25,
                                  color: c.c5,
                                ),
                                selectedIcon: Icon(
                                  CupertinoIcons.settings,
                                  size: 30,
                                  color: c.c3,
                                ),
                                label: Text(
                                  lan(t.settings),
                                  style: s.t(
                                    color: c.c3,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    Expanded(child: vm.currentBody),
                  ],
                ),
              ),
              floatingActionButton: vm.currentFAB,
              bottomNavigationBar:
                  constraints.maxWidth > 600 && constraints.maxHeight > 500
                      ? const SizedBox.shrink()
                      : Container(
                          color: c.c3,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 15,
                          ),
                          child: GNav(
                            gap: 8,
                            selectedIndex: vm.currentIndex,
                            onTabChange: vm.changeCurrentIndex,
                            backgroundColor: c.c3,
                            color: Colors.white,
                            activeColor: Colors.white,
                            tabBackgroundColor: c.c4,
                            padding: const EdgeInsets.all(15),
                            tabs: [
                              GButton(
                                icon: CupertinoIcons.news,
                                iconColor: c.c2,
                                iconActiveColor: c.c1,
                                text: lan(t.news),
                                iconSize: 35,
                              ),
                              GButton(
                                icon: CupertinoIcons.home,
                                iconColor: c.c2,
                                iconActiveColor: c.c1,
                                iconSize: 35,
                                text: lan(t.school),
                              ),
                              GButton(
                                icon: CupertinoIcons.person_2_fill,
                                text: lan(t.ourPride),
                                iconColor: c.c2,
                                iconActiveColor: c.c1,
                                iconSize: 35,
                              ),
                              GButton(
                                icon: CupertinoIcons.person_3_fill,
                                text: lan(t.teachers),
                                iconColor: c.c2,
                                iconSize: 35,
                                iconActiveColor: c.c1,
                              ),
                              GButton(
                                icon: CupertinoIcons.profile_circled,
                                text: lan(t.profile),
                                iconColor: c.c2,
                                iconSize: 35,
                                iconActiveColor: c.c1,
                              ),
                            ],
                          ),
                        ),
            );
          });
        },
      ),
    );
  }
}
/*

              CurvedNavigationBar(
                      backgroundColor: c.c1,
                      color: c.c3,
                      key: vm.bnbKey,
                      items: <Widget>[
                        Icon(
                          CupertinoIcons.news,
                          size: 35,
                          color: c.c1,
                        ),
                        Icon(
                          CupertinoIcons.home,
                          size: 35,
                          color: c.c1,
                        ),
                        Icon(
                          CupertinoIcons.person_2_fill,
                          size: 35,
                          color: c.c1,
                        ),
                        Icon(
                          CupertinoIcons.person_3_fill,
                          size: 35,
                          color: c.c1,
                        ),
                        Icon(
                          CupertinoIcons.profile_circled,
                          size: 35,
                          color: c.c1,
                        ),
                      ],
                      onTap: (index) {
                        vm.changeCurrentIndex(index);
                      },
                    ),
*/
