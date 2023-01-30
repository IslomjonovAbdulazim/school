import 'package:ds/utils/errors.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../models/school_model.dart';
import '../../../../../services/fb_firestore_service.dart';
import '../../../../../us/text_field_us.dart';
import '../../../../../utils/hints.dart';
import '../../../../../utils/titles.dart';

class TReceptionTimeVM extends ChangeNotifier {
  DateTime? start;
  DateTime? end;
  List<int> selectedDays = [];
  ReceptionTimeModel? reception;
  bool isLoading = false;
  List<ReceptionTimeModel> data = [];
  ReceptionTimeModel? toCreate;
  Map<String, String?> errors = {};
  late TextFieldUS des;

  TReceptionTimeVM({
    bool i = true,
    this.data = const [],
    this.reception,
  }) {
    initData();
    if (i) {
      init();
      getData();
    }
  }

  void initData() async {
    des = TextFieldUS(
      controller: TextEditingController(
        text: reception?.des,
      ),
      title: lan(h.des),
    );
    start = reception?.start;
    end = reception?.end;
    selectedDays = reception?.days ?? [];
  }

  void init() {
    errors = {
      t.days: null,
      t.startTime: null,
      t.endTime: null,
    };
  }

  void initStart(Duration val) {
    start = DateTime(2023, 1, 1, val.inHours, val.inMinutes % 60);
    notifyListeners();
  }

  void initEnd(Duration val) {
    end = DateTime(2023, 1, 1, val.inHours, val.inMinutes % 60);
    notifyListeners();
  }

  void getData() async {
    _update();
    data = (await fb.school())?.receptionTime ?? [];
    data.sort((a, b) => b.time.compareTo(a.time));
    _update();
  }

  void selectDay(int day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    notifyListeners();
  }

  bool check() {
    if (selectedDays.isEmpty) {
      errors.addAll({t.days: lan(myErrors.selectDays)});
    } else {
      errors.addAll({t.days: null});
    }
    if (start == null) {
      errors.addAll({t.startTime: lan(myErrors.startTime)});
    } else {
      errors.addAll({t.startTime: null});
    }
    if (end == null) {
      errors.addAll({t.endTime: lan(myErrors.endTime)});
    } else {
      errors.addAll({t.endTime: null});
    }
    notifyListeners();
    return !haveProblem;
  }

  bool get haveProblem => errors.values.where((element) {
        return element != null;
      }).isNotEmpty;

  Future<bool> delete() async {
    try {
      _update();
      data.removeWhere((element) => element.time == reception!.time);
      await fb.updateReceptionTime(data);
      return true;
    } catch(e) {
      print('delete: $e');
      _update();
      return false;
    }
  }

  Future<bool> create() async {
    final r = check();
    if (!r) {
      return false;
    }
    _update();
    toCreate = ReceptionTimeModel(
      days: selectedDays,
      start: start!,
      end: end!,
      des: des.controller.text,
      time: DateTime.now(),
    );
    data.add(toCreate!);
    data.sort((a, b) => b.time.compareTo(a.time));
    await fb.updateReceptionTime(data);
    _update();
    return true;
  }

  Future<bool> updateReceptionTime() async {
    final r = check();
    if (!r) {
      return false;
    }
    _update();
    var toUpdate = ReceptionTimeModel(
      days: selectedDays,
      start: start!,
      end: end!,
      des: des.controller.text,
      time: reception!.time,
    );
    data.removeWhere((element) => element.time == toUpdate.time);
    data.add(toUpdate);
    data.sort((a, b) => b.time.compareTo(a.time));
    await fb.updateReceptionTime(data);
    _update();
    return true;
  }

  void update() {
    // this.data.add(data);
    notifyListeners();
  }

  void _update() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
