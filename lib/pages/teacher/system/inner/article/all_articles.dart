import 'package:ds/pages/teacher/system/inner/article/article_page.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/titles.dart';

class TAllArticles extends StatelessWidget {
  const TAllArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c.c1,
      appBar: AppBar(
        backgroundColor: c.c3,
        title: Text(
          lan(t.myArticles),
          style: s.t(
            color: c.c1,
            size: 20,
            weight: FontWeight.w700,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TArticlePage(),
            ),
          );
        },
        backgroundColor: c.c3,
        child: Icon(
          CupertinoIcons.add,
          color: c.c1,
          size: 30,
        ),
      ),
    );
  }
}
