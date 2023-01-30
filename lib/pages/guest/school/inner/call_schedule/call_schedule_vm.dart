import 'package:ds/models/school_model.dart';
import 'package:ds/us/text_field_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:ds/utils/lan/en.dart';
import 'package:flutter/material.dart';
import '../../../../../services/fb_firestore_service.dart';
import '../../../../../utils/hints.dart';
import '../../../../../utils/titles.dart';

class GCallScheduleVM extends ChangeNotifier {
  Duration? start;
  Duration? end;
  bool isLoading = false;
  List<Deleted> schedules = [];
  TextFieldUS des = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.des),
    isMultiline: true,
  );
  Map<String, String?> errors = {};

  GCallScheduleVM([bool a = true]) {
    _init();
    if (a) {
      init();
    }
  }

  void _init() {
    errors = {
      t.startTime: null,
      t.endTime: null,
      h.des: null,
    };
  }

  void sort() {
    schedules.sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  void init() async {
    _update();
    // schedules = (await fb.school())!.tables;
    sort();
    _update();
  }

  Future<Deleted> update() async {
    _update();
    final e = DateTime(2023, 3, 3, end!.inHours, end!.inMinutes % 60);
    final s = DateTime(2023, 3, 3, start!.inHours, start!.inMinutes % 60);
    Deleted schedule = Deleted(
      des: des.controller.text,
      endTime: e,
      startTime: s,
    );
    schedules.add(schedule);
    sort();
    await fb.updateSchedule(schedules);
    _update();
    return schedule;
  }

  void initEnd(Duration val) {
    end = val;
    notifyListeners();
  }

  void initStart(Duration val) {
    start = val;
    notifyListeners();
  }

  void setState(Deleted schedule) {
    schedules.add(schedule);
    notifyListeners();
  }

  void _update() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
