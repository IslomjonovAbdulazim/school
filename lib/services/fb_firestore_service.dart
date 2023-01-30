import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds/models/article_model.dart';
import 'package:ds/models/director_model.dart';
import 'package:ds/models/generate_model.dart';
import 'package:ds/models/post_model.dart';
import 'package:ds/models/pride_model.dart';
import 'package:ds/models/school_model.dart';
import 'package:ds/models/science_model.dart';
import 'package:ds/models/statutes_model.dart';
import 'package:ds/models/teacher_model.dart';
import 'package:ds/services/fb_auth_service.dart';
import 'package:ds/utils/def.dart';
import 'dart:developer' as dev;
import '../utils/api.dart';
import '../utils/keys.dart';
import '../utils/titles.dart';

final _fb = FirebaseFirestore.instance;
final fb = FirestoreService.instance;
String centerId = "EbNRkGPoKJYYbkmUuuiaDXKmkZe2";

class FirestoreService {
  FirestoreService._();

  static FirestoreService instance = FirestoreService._();

  Future<String?> updateClass(ScheduleClassModel schedule) async {
    try {
      await _fb
          .collection(api.schedules)
          .doc(auth.id)
          .collection(auth.id)
          .doc(schedule.id)
          .update(schedule.toJson());
      return null;
    } catch (e) {
      print('updateClass: $e');
      return def.unknownError;
    }
  }

  Future<String?> delete(ScheduleClassModel data) async {
    try {
      await _fb
          .collection(api.schedules)
          .doc(auth.id)
          .collection(auth.id)
          .doc(data.id)
          .delete();
      return null;
    } catch (e) {
      print('delete: $e');
      return null;
    }
  }

  Future<String?> addClass(ScheduleClassModel schedule) async {
    try {
      _fb
          .collection(api.schedules)
          .doc(auth.id)
          .collection(auth.id)
          .add(schedule.toJson())
          .then((value) {
        schedule.id = value.id;
        _fb
            .collection(api.schedules)
            .doc(auth.id)
            .collection(auth.id)
            .doc(schedule.id)
            .set(schedule.toJson());
      });
      return null;
    } catch (e) {
      print('addSchedule: $e');
      return def.unknownError;
    }
  }

  Future<ScienceModel?> getScience([String? id]) async {
    try {
      String? s = (await getTeacher(id))?.detail.science;
      List<ScienceModel> sciences = await getAllSciences();
      if (s == null) return null;
      return sciences.firstWhere((element) => element.id == s);
    } catch (e) {
      print('getScience: $e');
      return null;
    }
  }

  Future<String?> uploadPride(PrideModel pride) async {
    try {
      await _fb.collection(api.pride).add(pride.toJson()).then((value) async {
        pride.id = value.id;
        await _fb.collection(api.pride).doc(pride.id).update(pride.toJson());
      });
      return null;
    } catch (e) {
      return def.unknownError;
    }
  }

  Future<String?> updateReceptionTime(List<ReceptionTimeModel> data) async {
    try {
      await _fb.collection(api.schools).doc(auth.id).update({
        "receptionTime": data.map((e) => e.toJson()).toList(),
      });
      return null;
    } catch (e) {
      print('updateReceptionTime: $e');
      return def.unknownError;
    }
  }

  Future<String?> updateSchedule(List<Deleted> schedules) async {
    try {
      await _fb.collection(api.schools).doc(auth.id).update({
        "tables": schedules.map((e) => e.toJson()).toList(),
      });
      return null;
    } catch (e) {
      print('updateSchedule: $e');
      return def.unknownError;
    }
  }

  Future<SchoolModel?> school() async {
    try {
      final d = await _fb.collection(api.schools).doc(centerId).get();
      return SchoolModel.fromJson(d.data()!);
    } catch (e) {
      print('schoolBio: $e');
      return null;
    }
  }

  Future<String?> updateBio(SchoolBioModel bio) async {
    try {
      await _fb.collection(api.schools).doc(auth.id).update(
        {"bio": bio.toJson()},
      );
      return null;
    } catch (e) {
      dev.log('updateBio', error: e, level: 3);
      return 'erorr';
    }
  }

  Query<PostModel> schoolPosts([String? byId]) => _fb
      .collection(api.posts)
      .where('byId', isEqualTo: byId)
      .withConverter<PostModel>(
        fromFirestore: ((snapshot, options) =>
            PostModel.fromJson(snapshot.data()!)),
        toFirestore: ((value, options) => value.toJson()),
      );

  Query<PostModel> sciencePosts(String scienceId) => _fb
      .collection(api.posts)
      .where('science', isEqualTo: scienceId)
      .withConverter<PostModel>(
        fromFirestore: ((snapshot, options) =>
            PostModel.fromJson(snapshot.data()!)),
        toFirestore: ((value, options) => value.toJson()),
      );

  Query<ScheduleClassModel> schedules([String? byId]) => _fb
      .collection(api.schedules)
      .doc(byId ?? auth.id)
      .collection(byId ?? auth.id)
      .withConverter<ScheduleClassModel>(
        fromFirestore: ((snapshot, options) =>
            ScheduleClassModel.fromJson(snapshot.data()!)),
        toFirestore: ((value, options) => value.toJson()),
      );

  Query<PrideModel> prides([String? byId]) =>
      _fb.collection(api.pride).withConverter<PrideModel>(
            fromFirestore: ((snapshot, options) =>
                PrideModel.fromJson(snapshot.data()!)),
            toFirestore: ((value, options) => value.toJson()),
          );

  Query<TeacherModel> teachers() {
    return _fb.collection(api.teachers).withConverter<TeacherModel>(
          fromFirestore: ((snapshot, options) {
            return TeacherModel.fromJson(snapshot.data()!);
          }),
          toFirestore: ((value, options) => value.toJson()),
        );
  }

  Future<String?> articleModel(ArticleModel article) async {
    try {
      await _fb
          .collection(api.articles)
          .add(article.toJson())
          .then((value) async {
        article.id = value.id;
        await _fb
            .collection(api.articles)
            .doc(article.id)
            .update(article.toJson());
      });
      return null;
    } catch (e) {
      print('articleModel: $e');
      return def.unknownError;
    }
  }

  Future<String?> updatePost(PostModel post) async {
    try {
      await _fb.collection(api.posts).doc(post.id).update(post.toJson());
      return null;
    } catch (e) {
      print('updatePosts: $e');
      return def.unknownError;
    }
  }

  Future<String?> updatePride(PrideModel post) async {
    try {
      await _fb.collection(api.pride).doc(post.id).update(post.toJson());
      return null;
    } catch (e) {
      print('updatePride: $e');
      return def.unknownError;
    }
  }

  Future<String?> uploadSchoolPost(PostModel post, [String? id]) async {
    try {
      await _fb
          .collection(api.posts)
          .add(
            post.toJson(),
          )
          .then(
        (value) async {
          post.id = value.id;
          await _fb.collection(api.posts).doc(post.id).set(
                post.toJson(),
              );
        },
      );
      return null;
    } catch (e) {
      print('uploadPost: $e');
      return def.unknownError;
    }
  }

  Future<String?> updateDirector(DirectorModel director) async {
    try {
      await _fb
          .collection(api.directors)
          .doc(director.id)
          .update(director.toJson());
      return null;
    } catch (e) {
      print('updateDirector: $e');
      return null;
    }
  }

  Future<String?> updateTeacher(TeacherModel teacher) async {
    try {
      await _fb
          .collection(api.teachers)
          .doc(teacher.id)
          .update(teacher.toJson());
      return null;
    } catch (e) {
      print('updateTeacher: $e');
      return null;
    }
  }

  Future<DirectorModel?> getDirector() async {
    try {
      final data = await _fb.collection(api.directors).doc(auth.id).get();
      if (data.data() == null) return null;
      return DirectorModel.fromJson(data.data()!);
    } catch (e) {
      print('director: $e');
      return null;
    }
  }

  Future<TeacherModel?> getTeacher([String? id]) async {
    try {
      final data = await _fb.collection(api.teachers).doc(id ?? auth.id).get();
      if (data.data() == null) return null;
      return TeacherModel.fromJson(data.data()!);
    } catch (e) {
      print('getTeacher: $e');
      return null;
    }
  }

  Future<String?> deleteChapter(StatuteModel statuate) async {
    try {
      await _fb
          .collection(api.statutes)
          .doc(auth.id)
          .collection(auth.id)
          .doc(statuate.id)
          .delete();
      return null;
    } catch (e) {
      print('deleteChapter: $e');
      return def.unknownError;
    }
  }

  Future<String?> updateChapter(StatuteModel statute) async {
    try {
      await _fb
          .collection(api.statutes)
          .doc(auth.id)
          .collection(auth.id)
          .doc(statute.id)
          .update(
            statute.toJson(),
          );
      return null;
    } catch (e) {
      print('updateChapter: $e');
      return def.unknownError;
    }
  }

  Future<String?> createChapter(StatuteModel statute) async {
    try {
      await _fb
          .collection(api.statutes)
          .doc(auth.id)
          .collection(auth.id)
          .add(statute.toJson())
          .then((value) async {
        statute.id = value.id;
        await _fb
            .collection(api.statutes)
            .doc(auth.id)
            .collection(auth.id)
            .doc(value.id)
            .update(statute.toJson());
      });
      return null;
    } catch (e) {
      print('createStatute: $e');
      return def.unknownError;
    }
  }

  Future<List<StatuteModel>> getAllStatutes() async {
    try {
      final dat = await _fb
          .collection(api.statutes)
          .doc('EbNRkGPoKJYYbkmUuuiaDXKmkZe2')
          .collection('EbNRkGPoKJYYbkmUuuiaDXKmkZe2')
          .get();
      final List<StatuteModel> data = dat.docs
          .map(
            (e) => StatuteModel.fromJson(
              e.data(),
            ),
          )
          .toList();
      return data;
    } catch (e) {
      print('getAllStatute: $e');
      return [];
    }
  }

  Future<String?> deletePost(PostModel post) async {
    try {
      await _fb.collection(api.posts).doc(post.id).delete();
    } catch (e) {
      print('deletePost: $e');
      return def.unknownError;
    }
  }

  Future<String?> deleteScience(ScienceModel science) async {
    try {
      await _fb
          .collection(api.sciences)
          .doc(auth.id)
          .collection(auth.id)
          .doc(science.id)
          .delete();
      return null;
    } catch (e) {
      print('deleteScience: $e');
      return def.unknownError;
    }
  }

  Future<List<ScienceModel>> getAllSciences() async {
    final dat = await _fb
        .collection(api.sciences)
        .doc(centerId)
        .collection(centerId)
        .get();
    final data = dat.docs.map((e) => ScienceModel.fromJson(e.data())).toList();
    return data;
  }

  Future<String?> updateScience(ScienceModel science) async {
    try {
      await _fb
          .collection(api.sciences)
          .doc(auth.id)
          .collection(auth.id)
          .doc(science.id)
          .update(
            science.toJson(),
          );
      return null;
    } catch (e) {
      print('updateScience: $e');
      return def.unknownError;
    }
  }

  Future<String?> addScience(ScienceModel science) async {
    try {
      await _fb
          .collection(api.sciences)
          .doc(auth.id)
          .collection(auth.id)
          .add(
            science.toJson(),
          )
          .then(
        (value) async {
          science.id = value.id;
          await _fb
              .collection(api.sciences)
              .doc(auth.id)
              .collection(auth.id)
              .doc(science.id)
              .set(
                science.toJson(),
              );
        },
      );
      return null;
    } catch (e) {
      print('addScience: $e');
      return def.unknownError;
    }
  }

  Future<String?> signUpTeacher(TeacherModel teacher) async {
    try {
      await _fb.collection(api.teachers).doc(teacher.id).set(
            teacher.toJson(),
          );
      return null;
    } catch (e) {
      print('signUpTeacher: $e');
      return def.unknownError;
    }
  }

  Future<String?> createSchool(SchoolModel school) async {
    try {
      school.id = auth.id;
      await _fb.collection(api.schools).doc(school.id).set(school.toJson());
      return null;
    } catch (e) {
      print('createSchool: $e');
      return def.unknownError;
    }
  }

  Future<String?> signUpDirector(DirectorModel director) async {
    try {
      await _fb.collection(api.directors).doc(director.id).set(
            director.toJson(),
          );
      return null;
    } catch (e) {
      print('signUpDirector: $e');
      return def.unknownError;
    }
  }

  Future<GenerateModel?> generate(String type) async {
    try {
      final g = GenerateModel(
        time: DateTime.now(),
        code: 'none',
        type: type,
        center: auth.id,
      );
      await _fb.collection(api.generate).add(g.toJson()).then(
        (value) async {
          g.code = value.id;
          await _fb.collection(api.generate).doc(g.code).set(g.toJson());
        },
      );
      return g;
    } catch (e) {
      return null;
    }
  }

  Future<List<GenerateModel>> getAllGenerate() async {
    try {
      final data = await _fb.collection(api.generate).get();
      final result =
          data.docs.map((e) => GenerateModel.fromJson(e.data())).toList();
      return result;
    } catch (e) {
      print('getAllGenerate: $e');
      return [];
    }
  }

  Future<String?> deleteToken(GenerateModel token) async {
    try {
      await _fb.collection(api.generate).doc(token.code).delete();
      return null;
    } catch (e) {
      print('deleteToken: $e');
      return def.unknownError;
    }
  }

  Future<String?> checkToken(String token) async {
    try {
      final d = await _fb.collection(api.generate).get();
      final da = d.docs.map((e) => GenerateModel.fromJson(e.data())).toList();
      final dat = da.where((element) => element.code == token).toList();
      if (dat.length == 1) {
        final data = dat.first;
        if (data.type == keys.director) {
          return t.loginAsDirector;
        } else {
          return t.logInAsTeacher;
        }
      } else {
        return def.invalidValue;
      }
    } catch (e) {
      print('checkToken: $e');
      return def.unknownError;
    }
  }
}
