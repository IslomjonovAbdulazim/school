import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/titles.dart';

class TLanPage extends StatelessWidget {
  const TLanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c.c1,
      appBar: AppBar(
        backgroundColor: c.c3,
        title: Text(
          lan(t.selectLan),
          style: s.t(
            color: c.c1,
            size: 20,
            weight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        children: t.lan1
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  onTap: () async {
                    lan.change(e).then((value) {
                      Navigator.pop(context, 'yes');
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: c.c2,
                  title: Text(
                    lan(e.currLan),
                    style: s.t(
                      color: c.c3,
                      size: 17.5,
                      weight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    e.lan,
                    style: s.t(
                      color: c.c3,
                      size: 15,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
