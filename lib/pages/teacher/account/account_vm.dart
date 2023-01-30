import 'dart:io';
import 'package:ds/models/director_model.dart';
import 'package:ds/models/teacher_model.dart';
import 'package:ds/services/fb_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/post_model.dart';
import '../../../services/fb_firestore_service.dart';

class TAccountVM extends ChangeNotifier {
  TextEditingController? name;
  TextEditingController? bio;
  List<TextEditingController> tel = [];
  TeacherModel? teacher;
  bool isLoading = false;
  BodyModel? selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool isChanged = false;

  void save() async {
    update();
    if (selectedImage != null) {
      if (teacher!.detail.avatar != null) {
        await storage.deleteFile(teacher!.detail.avatar!);
      }
      selectedImage = await storage.uploadFile(selectedImage!);
      teacher!.detail.avatar = selectedImage;
    }
    teacher!.detail.bio = bio!.text;
    teacher!.detail.fullname = name!.text;
    teacher!.detail.tel = tel.map((e) => e.text).toList();
    await fb.updateTeacher(teacher!);
    selectedImage = null;
    update();
  }

  void init() async {
    update();
    teacher = await fb.getTeacher();
    name = TextEditingController(text: teacher?.detail.fullname);
    bio = TextEditingController(text: teacher?.detail.bio);
    tel = teacher?.detail.tel
            .map((e) => TextEditingController(text: e))
            .toList() ??
        [
          TextEditingController(),
        ];
    update();
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

  void update() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void nf() {
    notifyListeners();
  }

  void addTel() {
    tel.add(TextEditingController());
    notifyListeners();
  }

  void deleteTel(TextEditingController controller) {
    tel.remove(controller);
    notifyListeners();
  }

  TAccountVM() {
    init();
  }
}
