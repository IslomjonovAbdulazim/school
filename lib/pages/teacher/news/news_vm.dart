import 'package:ds/services/fb_firestore_service.dart';
import 'package:flutter/material.dart';

import '../../../models/science_model.dart';

class TNewsVM extends ChangeNotifier {
  String? centerId;
  List<ScienceModel> allSciences = [];
  bool isLoading = false;

  TNewsVM() {
    if (centerId != null) return;
    _update();
    fb.getTeacher().then((value) {
      centerId = value?.centerId;
      notifyListeners();
    });
    fb.getAllSciences().then((value) {
      allSciences = value;
    });
    _update();
  }

  String getScience(String id) {
    if (allSciences.isEmpty) return '';
    return allSciences.firstWhere((element) => element.id == id).name;
  }
  void _update() {
    isLoading = !isLoading;
    notifyListeners();
  }

}
