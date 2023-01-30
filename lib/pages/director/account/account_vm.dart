import 'dart:io';

import 'package:ds/models/director_model.dart';
import 'package:ds/services/fb_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/post_model.dart';
import '../../../services/fb_firestore_service.dart';

class DAccountVM extends ChangeNotifier {
  TextEditingController? name;
  List<TextEditingController> tel = [];
  TextEditingController? bio;
  DirectorModel? director;
  bool isLoading = false;
  BodyModel? selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool isChanged = false;

  DAccountVM() {
    init();
  }

  void save() async {
    _update();
    if (selectedImage != null) {
      if (director!.detail.avatar != null) {
        await storage.deleteFile(director!.detail.avatar!);
      }
      selectedImage = await storage.uploadFile(selectedImage!);
      director!.detail.avatar = selectedImage;
    }
    director!.detail.bio = bio!.text;
    director!.detail.fullame = name!.text;
    director!.detail.tel = tel.map((e) => e.text).toList();
    await fb.updateDirector(director!);
    selectedImage = null;
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

  void nf() {
    notifyListeners();
  }

  void init() async {
    _update();
    director = await fb.getDirector();
    name = TextEditingController(text: director?.detail.fullame);
    bio = TextEditingController(text: director?.detail.bio);
    tel = director?.detail.tel
            .map(
              (e) => TextEditingController(text: e),
            )
            .toList() ??
        [
          TextEditingController(),
        ];
    _update();
  }

  void pickImage() async {
    final XFile? _image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (_image == null) return;
    isChanged = true;
    final image = File(_image.path);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    selectedImage = BodyModel(
      deletePath: '',
      height: decodedImage.height.toDouble(),
      isImage: true,
      path: _image.path,
      width: decodedImage.width.toDouble(),
    );
    notifyListeners();
  }

  void _update() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
