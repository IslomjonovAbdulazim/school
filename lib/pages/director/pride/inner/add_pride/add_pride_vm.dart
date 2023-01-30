import 'dart:io';

import 'package:ds/models/pride_model.dart';
import 'package:ds/us/text_field_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../models/post_model.dart';
import '../../../../../services/fb_firestore_service.dart';
import '../../../../../services/fb_storage_service.dart';
import '../../../../../utils/hints.dart';

class AddPrideVM extends ChangeNotifier {
  double? height;
  double? width;
  int current = 0;
  final ImagePicker _picker = ImagePicker();

  late TextFieldUS fullname;
  late TextFieldUS why;
  List<BodyModel> media = [];
  bool isLoading = false;

  AddPrideVM([PrideModel? pride]) {
    fullname = TextFieldUS(
      controller: TextEditingController(text: pride?.fullname),
      isMultiline: true,
      title: lan(h.fullname),
    );
    why = TextFieldUS(
      controller: TextEditingController(text: pride?.why),
      isMultiline: true,
      title: lan(h.why),
    );
    media = pride?.media.map((e) {
          e.isUploaded = true;
          return e;
        }).toList() ??
        [];
    if (media.isNotEmpty) {
      initRation(0);
    }
  }

  Future<bool> updatePride(String id) async {
    _update();
    final post = PrideModel(
      fullname: fullname.controller.text,
      time: DateTime.now(),
      media: media,
      why: why.controller.text,
      id: id,
    );
    final res = await fb.updatePride(post);
    _update();
    return res == null;
  }

  void initCurrent(int index) {
    current = index;
  }

  Future<bool> uploadPost() async {
    _update();
    List<BodyModel> _body = [];
    for (final a in media) {
      final res = await storage.uploadFile(a);
      if (res == null) return false;
      _body.add(res);
    }
    final post = PrideModel(
      fullname: fullname.controller.text,
      time: DateTime.now(),
      media: _body,
      why: why.controller.text,
      id: 'id',
    );
    final res = await fb.uploadPride(post);
    _update();
    return res == null;
  }

  void pickImage() async {
    final XFile? _image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (_image == null) return;
    final image = File(_image.path);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    final _ = BodyModel(
      height: decodedImage.height.toDouble(),
      isImage: true,
      path: _image.path,
      deletePath: '',
      width: decodedImage.width.toDouble(),
    );
    media.add(_);
    if (media.length == 1) {
      initRation(0);
    }
    notifyListeners();
  }

  void initRation(int a) {
    final b = media[a];
    height = b.height;
    width = b.width;
    current = a;
    notifyListeners();
  }

  void remove() {
    media.removeAt(current);
    notifyListeners();
  }

  void _update() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
