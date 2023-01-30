import 'package:ds/models/director_model.dart';
import 'package:ds/models/teacher_model.dart';
import 'package:ds/utils/def.dart';
import 'package:ds/utils/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
final auth = AuthService.instance;

class AuthService {
  AuthService._();

  static AuthService instance = AuthService._();

  Stream<User?> stream() => _auth.userChanges();

  String get id => _auth.currentUser!.uid;

  Future<String?> signIn(String nick, String password, String end) async {
    try {
      print('$nick.$end@gmail.com');
      await _auth.signInWithEmailAndPassword(
        email: '$nick.$end@gmail.com',
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return myErrors.userNotFound;
      } else if (e.code == 'wrong-password') {
        return myErrors.wrongPassword;
      } else {
        return def.unknownError;
      }
    } catch (e) {
      print('signIn: $e');
      return def.unknownError;
    }
  }

  Future<String?> signUpDirector(DirectorModel director) async {
    try {
      final res = await _auth.createUserWithEmailAndPassword(
        email: '${director.detail.nick}.director@gmail.com',
        password: director.detail.password,
      );
      return res.user!.uid;
    } catch (e) {
      print('signUpDirector: $e');
      return def.unknownError;
    }
  }

  Future<String?> signUpTeacher(TeacherModel teacher) async {
    try {
      final res = await _auth.createUserWithEmailAndPassword(
        email: '${teacher.detail.nick}.teacher@gmail.com',
        password: teacher.detail.password,
      );
      return res.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return myErrors.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        return myErrors.usedNick;
      } else if (e.code == 'invalid-email') {
        return myErrors.invalidNick;
      }
    } catch (e) {
      return def.unknownError;
    }
  }

  void signOut() {
    _auth.signOut();
  }
}
