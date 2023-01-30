import 'dart:async';
import 'dart:io';
import 'package:ds/models/post_model.dart';
import 'package:ds/services/fb_auth_service.dart';
import 'package:ds/services/fb_firestore_service.dart';
import 'package:ds/services/fb_storage_service.dart';
import 'package:ds/us/text_field_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../utils/hints.dart';

class TPostsVM extends ChangeNotifier {
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  double? height;
  int current = 0;
  double? width;
  String? centerId;
  late TextFieldUS title;
  late TextFieldUS content;
  List<BodyModel> toDelete = [];
  List<BodyModel> body = [];

  TPostsVM(PostModel? post) {
    fb.getTeacher().then((value) {
      centerId = value?.centerId;
      notifyListeners();
    });
    title = TextFieldUS(
      controller: TextEditingController(text: post?.title),
      title: lan(h.title),
      isMultiline: true,
    );
    content = TextFieldUS(
      controller: TextEditingController(text: post?.content),
      title: lan(h.des),
      isMultiline: true,
    );
    if (post != null) {
      init(post);
    }
  }

  void init(PostModel post) {
    body = post.body.map((e) {
      e.isUploaded = true;
      return e;
    }).toList();
    if (body.isNotEmpty) {
      initRation(0);
    }
  }

  void initRation(int a) {
    final b = body[a];
    height = b.height;
    width = b.width;
    notifyListeners();
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
      isUploaded: false,
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

  Future<void> uploadPost(String science, [PostModel? p1]) async {
    _update();
    List<BodyModel> _body = [];
    if (p1 != null) {
      for (final a in toDelete) {
        await storage.deleteFile(a);
      }
    }
    for (final a in body) {
      final res = await storage.uploadFile(a);
      if (res == null) return;
      _body.add(res);
    }
    String? id = (await fb.getTeacher())?.centerId;
    final post = PostModel(
      content: content.controller.text,
      title: title.controller.text,
      body: _body,
      comments: p1?.comments ?? [],
      liked: p1?.liked ?? [],
      watched: p1?.watched ?? [],
      id: p1?.id ?? 'id',
      byId: auth.id,
      time: DateTime.now(),
      science: science,
    );
    if (p1 != null) {
      await fb.updatePost(post);
    } else {
      await fb.uploadSchoolPost(post, id);
    }
    _update();
  }

  Future<bool> deletePost(PostModel post) async {
    _update();
    for (final a in post.body) {
      if (a.isUploaded == true) {
        await storage.deleteFile(a);
      }
    }
    late bool res;
    await fb.deletePost(post).then((value) {
      res = value != null;
      _update();
    });
    return res;
  }

  void _update() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void deleteImage(BodyModel b) async {
    body.remove(b);
    if (b.isUploaded == true) {
      toDelete.add(b);
    }
    notifyListeners();
  }
}
