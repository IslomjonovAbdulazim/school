import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../models/post_model.dart';
import '../../../../../../services/fb_auth_service.dart';
import '../../../../../../services/fb_firestore_service.dart';
import '../../../../../../services/fb_storage_service.dart';
import '../../../../../../us/text_field_us.dart';
import '../../../../../../utils/hints.dart';
import '../../../../../../utils/lan.dart';

class DSchoolEditPostVM extends ChangeNotifier {
  double? height;
  double? width;
  int current = 0;
  final ImagePicker _picker = ImagePicker();
  late DateTime time;
  late TextFieldUS title;
  late TextFieldUS des;
  List<BodyModel> media = [];
  bool isLoading = false;


  DSchoolEditPostVM(PostModel pride) {
    time = pride.time;
    title = TextFieldUS(
      controller: TextEditingController(text: pride.title),
      isMultiline: true,
      title: lan(h.title),
    );
    des = TextFieldUS(
      controller: TextEditingController(text: pride.content),
      isMultiline: true,
      title: lan(h.title),
    );
    media = pride.body.map((e) {
          e.isUploaded = true;
          return e;
        }).toList() ??
        [];
    if (media.isNotEmpty) {
      initRation(0);
    }
  }

  Future<bool> updatePost(String id) async {
    _update();
    final post = PostModel(
      content: des.controller.text,
      title: title.controller.text,
      body: media,
      comments: [],
      liked: [],
      watched: [],
      id: id,
      byId: auth.id,
      time: time,
    );
    final res = await fb.updatePost(post);
    _update();
    return res == null;
  }

  void initCurrent(int index) {
    current = index;
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
