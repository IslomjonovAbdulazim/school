import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../utils/colors.dart';
import 'bnb_vm.dart';

class GBNBPage extends StatelessWidget {
  const GBNBPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GBNBVM(context),
      child: Consumer<GBNBVM>(
        builder: (context, GBNBVM vm, _) {
          return Scaffold(
            appBar: vm.currentAppBar,
            backgroundColor: c.c1,
            body: SafeArea(
              top: false,
              child: vm.currentBody,
            ),
            floatingActionButton: vm.currentFAB,
            bottomNavigationBar: CurvedNavigationBar(
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
                  CupertinoIcons.person_2_alt,
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
          );
        },
      ),
    );
  }
}
