import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ds/models/post_model.dart';
import 'package:ds/services/fb_auth_service.dart';
import 'package:ds/services/fb_firestore_service.dart';
import 'package:ds/services/fb_storage_service.dart';
import 'package:ds/us/text_field_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../utils/hints.dart';
import 'dart:developer' as developer;

class DSchoolPostsVM extends ChangeNotifier {
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  double? height;
  double? width;
  int current = 0;
  final CarouselController controller = CarouselController();

  void initRation(int a) {
    final b = body[a];
    height = b.height;
    width = b.width;
    notifyListeners();
  }

  void initCurrent(int index) {
    current = index;
  }

  TextFieldUS title = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.title),
    isMultiline: true,
  );
  TextFieldUS content = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.des),
    isMultiline: true,
  );

  List<BodyModel> body = [];

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
    body.add(_);
    if (body.length == 1) {
      initRation(0);
    }
    notifyListeners();
  }

  void pickVideo() async {
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.gallery,
    );
  }

  Future<void> uploadPost() async {
    _update();
    List<BodyModel> _body = [];
    for (final a in body) {
      final res = await storage.uploadFile(a);
      if (res == null) return;
      _body.add(res);
    }
    final post = PostModel(
      content: content.controller.text,
      title: title.controller.text,
      body: _body,
      comments: [],
      liked: [],
      watched: [],
      id: 'id',
      byId: auth.id,
      time: DateTime.now(),
    );
    await fb.uploadSchoolPost(post);
    _update();
  }

  void _update() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
