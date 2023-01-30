import 'package:ds/models/school_model.dart';
import 'package:ds/services/fb_auth_service.dart';
import 'package:ds/us/text_field_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:ds/utils/lan/en.dart';
import 'package:flutter/material.dart';
import '../../../../../services/fb_firestore_service.dart';
import '../../../../../utils/hints.dart';
import '../../../../../utils/titles.dart';

class TCallScheduleVM extends ChangeNotifier {
  Duration? start;
  Duration? end;
  bool isLoading = false;
  String? centerId;
  TextFieldUS des = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.des),
    isMultiline: true,
  );
  Map<String, String?> errors = {};

  TCallScheduleVM([bool a = true]) {
    _update();
    _init();
    fb.getTeacher(auth.id).then((value) {
      centerId = value!.centerId;
      _update();
    });
  }

  void _init() {
    errors = {
      t.startTime: null,
      t.endTime: null,
      h.des: null,
    };
  }

  void nf() {
    notifyListeners();
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
    notifyListeners();
  }

  void _update() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
