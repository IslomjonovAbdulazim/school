import 'package:ds/models/science_model.dart';
import 'package:ds/us/text_field_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../services/fb_firestore_service.dart';
import '../../../../../utils/hints.dart';
import '../../../../../utils/titles.dart';

class DSciencesVM extends ChangeNotifier {
  bool isLoading = false;
  ScienceModel? science;

  DSciencesVM(this.science) {
    name.controller.text = science?.name ?? '';
    des.controller.text = science?.des ?? '';
  }

  TextFieldUS name = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.name),
  );
  TextFieldUS des = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.des),
    isMultiline: true,
  );

  Future<void> create(List<ScienceModel> sciences) async {
    isLoading = true;
    notifyListeners();
    final science = ScienceModel(
      name: name.controller.text.trim(),
      des: des.controller.text.trim(),
      id: 'id',
    );
    sciences.add(science);
    await fb.addScience(science);
    isLoading = false;
    notifyListeners();
  }

  Future<void> update(List<ScienceModel> sciences) async {
    isLoading = true;
    notifyListeners();
    final s = ScienceModel(
      name: name.controller.text.trim(),
      des: des.controller.text.trim(),
      id: science!.id,
    );
    sciences.add(s);
    await fb.updateScience(s);
    isLoading = false;
    notifyListeners();
  }

  Future<void> delete(List<ScienceModel> sciences) async {
    isLoading = true;
    notifyListeners();
    await fb.deleteScience(science!);
    sciences = sciences.skipWhile((value) => value.id == science!.id).toList();
    isLoading = false;
    notifyListeners();
  }
}
