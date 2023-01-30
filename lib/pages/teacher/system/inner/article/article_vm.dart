import 'dart:io';

import 'package:ds/us/text_field_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../models/article_model.dart';
import '../../../../../utils/titles.dart';

class TArticleVM extends ChangeNotifier {
  double bs = 80;
  List<ArticleModel> article = [];
  final ImagePicker _picker = ImagePicker();
  MediaModel? image;
  TextFieldUS des = TextFieldUS(
    controller: TextEditingController(),
    title: lan(t.des),
  );

  void getImage() async {
    final XFile? _image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (_image == null) return;
    final im = File(_image.path);
    var decodedImage = await decodeImageFromList(im.readAsBytesSync());
    image = MediaModel(
      deletePath: '',
      index: article.length,
      path: _image.path,
      width: decodedImage.width.toDouble(),
      height: decodedImage.height.toDouble(),
    );
    notifyListeners();
  }
}
