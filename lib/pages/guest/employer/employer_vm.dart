import 'package:flutter/cupertino.dart';

import '../../../models/science_model.dart';
import '../../../services/fb_firestore_service.dart';

class GEmployerVM extends ChangeNotifier {
  List<ScienceModel> sciences = [];
  bool isLoading = false;

  GEmployerVM() {
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