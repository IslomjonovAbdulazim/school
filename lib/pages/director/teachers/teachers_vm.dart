import 'package:flutter/cupertino.dart';

import '../../../models/science_model.dart';
import '../../../services/fb_firestore_service.dart';

class DTeachersVM extends ChangeNotifier {
  List<ScienceModel> sciences = [];
  bool isLoading = false;

  DTeachersVM() {
    init();
  }

  void init() async {
    _update();
    sciences = await fb.getAllSciences();
    _update();
  }

  void _update() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
