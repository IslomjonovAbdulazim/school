import 'dart:io';
import 'dart:typed_data';
import 'package:ds/models/post_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../utils/def.dart';

final storage = FBStorageService.instance;
final _storage = FirebaseStorage.instance.ref();

class FBStorageService {
  FBStorageService._();

  static FBStorageService instance = FBStorageService._();

  Future<String> getFile(BodyModel body) async {
    return await _storage.child(body.path).getDownloadURL();
  }

  Future<BodyModel?> uploadFile(BodyModel data) async {
    try {
      late BodyModel d;
      final path =
          '${DateTime.now().toIso8601String()}.:.${data.path.split('/').join('.')}';
      await _storage.child(path).putFile(File(data.path)).then((p0) async {
        String deletePath = _storage.child(path).name;
        await _storage.child(path).getDownloadURL().then((value) {
          d = BodyModel(
            height: data.height,
            isImage: data.isImage,
            path: value,
            width: data.width,
            deletePath: deletePath,
          );
        });
      });
      return d;
    } catch (e) {
      print('uploadFile: $e');
      return null;
    }
  }

  Future<String?> deleteFile(BodyModel body) async {
    try {
      print(body.path);
      await _storage.child(body.deletePath.split('/').last).delete();
      return null;
    } catch (e) {
      print('deleteFile: $e');
      return def.unknownError;
    }
  }
}
