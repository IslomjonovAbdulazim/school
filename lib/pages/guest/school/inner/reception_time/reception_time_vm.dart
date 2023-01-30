import 'package:ds/utils/errors.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../../../models/school_model.dart';
import '../../../../../services/fb_firestore_service.dart';
import '../../../../../us/text_field_us.dart';
import '../../../../../utils/hints.dart';
import '../../../../../utils/titles.dart';

class GReceptionTimeVM extends ChangeNotifier {
  DateTime? start;
  DateTime? end;
  List<int> selectedDays = [];
  bool isLoading = false;
  List<ReceptionTimeModel> data = [];
  ReceptionTimeModel? toCreate;
  Map<String, String?> errors = {};
  TextFieldUS des = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.des),
  );
  GReceptionTimeVM({bool i = true, this.data = const []}) {
    if (i) {
      init();
      getData();
    }
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


  void update(ReceptionTimeModel data) {
    // this.data.add(data);
    notifyListeners();
  }

  void _update() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
