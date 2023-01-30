import 'package:ds/models/statutes_model.dart';
import 'package:ds/services/fb_firestore_service.dart';
import 'package:ds/us/text_field_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/hints.dart';

class GWStatuteVM extends ChangeNotifier {
  bool isLoading = false;
  String? title;
  List<StatuteModel> data = [];

  GWStatuteVM(this.title, [StatuteModel? s]) {
    statute.controller.text = title ?? '';
    chapter.controller.text = s?.title ?? '';
  }

  TextFieldUS chapter = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.chapterName),
    isMultiline: true,
  );

  TextFieldUS statute = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.statute),
    isMultiline: true,
  );

  Future<void> createChapter(List<StatuteModel> statutes) async {
    _update();
    StatuteModel statute = StatuteModel(
      content: [],
      title: chapter.controller.text.trim(),
      time: DateTime.now(),
      id: 'id',
    );
    await fb.createChapter(statute);
    _update();
  }

  Future<void> createStatute(StatuteModel s) async {
    _update();
    s.content.add(statute.controller.text.trim());
    await fb.updateChapter(s);
    _update();
  }

  Future<void> deleteStatute(StatuteModel s) async {
    _update();
    s.content = s.content.skipWhile((value) {
      return value == title;
    }).toList();
    await fb.updateChapter(s);
    _update();
  }

  Future<void> deleteChapter(
    List<StatuteModel> statuates,
    StatuteModel s,
  ) async {
    _update();
    statuates.removeWhere((element) => element.id == s.id);
    await fb.deleteChapter(s);
    _update();
  }

  Future<void> updateStatute(StatuteModel s) async {
    _update();
    final List<String> n = [];
    for (var a in s.content) {
      if (a == title) {
        n.add(statute.controller.text.trim());
      } else {
        n.add(a);
      }
    }
    s.content = n;
    await fb.updateChapter(s);
    _update();
  }

  Future<void> updateChapter(StatuteModel statute) async {
    _update();
    statute.title = chapter.controller.text.trim();
    await fb.updateChapter(statute);
    _update();
  }

  void _update() async {
    isLoading = !isLoading;
    notifyListeners();
  }
}
