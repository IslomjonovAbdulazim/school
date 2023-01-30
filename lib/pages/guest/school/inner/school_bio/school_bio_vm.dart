import 'dart:io';

import 'package:ds/models/school_model.dart';
import 'package:ds/services/fb_firestore_service.dart';
import 'package:ds/services/fb_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../models/post_model.dart';

class GSchoolBioVM extends ChangeNotifier {
  List<TextEditingController> tel = [];
  bool isLoading = false;
  List<BodyModel> images = [];
  List<TextEditingController> socialMedia = [];
  Map<TextEditingController, TextEditingController> statistics = {};
  TextEditingController? des;
  TextEditingController? location;
  SchoolBioModel? bio;
  final ImagePicker _picker = ImagePicker();
  List<BodyModel> deleted = [];
  double? height;
  double? width;
  int current = 0;

  GSchoolBioVM() {
    init();
  }

  void init() async {
    _update();
    bio = (await fb.school())!.bio;
    des = TextEditingController(text: bio?.des);
    location = TextEditingController(text: bio?.location);
    Map<TextEditingController, TextEditingController> s = {};
    tel = bio!.tel.map((e) => TextEditingController(text: e)).toList();
    bio?.statistics.keys.map((e) {
      s.addAll({
        TextEditingController(text: e): TextEditingController(
          text: bio!.statistics[e],
        )
      });
    }).toList();
    statistics = s;
    images = bio?.images ?? [];
    if (images.isNotEmpty) {
      initR();
    }
    _update();
  }

  void change(int index) {
    current = index;
    initR();
    notifyListeners();
  }

  void initR() {
    height = images[current].height;
    width = images[current].width;
  }

  Future<void> update() async {
    _update();
    final Map<String, String> s = {};
    statistics.keys.map((e) {
      s.addAll({e.text: statistics[e]!.text});
    }).toList();
    List<BodyModel> deleted = [];
    List<BodyModel> news = [];
    images.map((e) {
      if (!(e.isUploaded ?? true)) {
        news.add(e);
      }
      final r = deleted
          .where((b) => e.isUploaded != false && b.path == e.path)
          .toList();
      deleted.addAll(r);
    }).toList();
    for (var i in deleted) {
      await storage.deleteFile(i);
    }
    for (final i in news) {
      final res = await storage.uploadFile(i);
      for (int j = 0; j < images.length; j++) {
        if (images[j].path == i.path) {
          images[j] = res!;
        }
      }
    }
    SchoolBioModel bio = SchoolBioModel(
      tel: tel.map((e) => e.text).toList(),
      images: images,
      socialMedia: socialMedia.map((e) => e.text).toList(),
      statistics: s,
      des: des?.text,
      location: location?.text,
    );
    await fb.updateBio(bio);
    _update();
  }

  void addTel() {
    tel.add(TextEditingController());
    notifyListeners();
  }

  void deleteTel(TextEditingController controller) {
    tel.remove(controller);
    notifyListeners();
  }

  void addStatistics() {
    statistics.addAll({TextEditingController(): TextEditingController()});
    notifyListeners();
  }

  void deleteStatistics(TextEditingController controller) {
    statistics.remove(controller);
    notifyListeners();
  }

  void _update() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void getImage() async {
    final XFile? _image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (_image == null) return;
    final image = File(_image.path);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    final _ = BodyModel(
      height: decodedImage.height.toDouble(),
      isImage: true,
      deletePath: '',
      path: _image.path,
      width: decodedImage.width.toDouble(),
      isUploaded: false,
    );
    images.add(_);
    notifyListeners();
  }

  void deleteImage(BodyModel body) {
    deleted.add(body);
    print('ddddddddddddddddddddd: ${deleted.first.toJson()} ========= ${deleted.first.isUploaded}');
    images.remove(body);
    notifyListeners();
  }
}
