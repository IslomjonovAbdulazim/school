import 'package:ds/models/director_model.dart';
import 'package:ds/models/generate_model.dart';
import 'package:ds/models/post_model.dart';
import 'package:ds/models/school_model.dart';
import 'package:ds/models/science_model.dart';
import 'package:ds/models/teacher_model.dart';
import 'package:ds/pages/log_in/sign_up_page.dart';
import 'package:ds/services/fb_firestore_service.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/us/text_field_us.dart';
import 'package:ds/utils/def.dart';
import 'package:ds/utils/errors.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/fb_auth_service.dart';
import '../../utils/colors.dart';
import '../../utils/hints.dart';
import '../../utils/keys.dart';
import '../../utils/titles.dart';

class LogInVM extends ChangeNotifier {
  bool isLoading = false;
  TextFieldUS? token;
  ButtonUS? checkToken;
  String? error;
  String? title;
  Map<String, String?> loginErrors = {};
  BuildContext context;
  List<TextFieldUS> signUpDirector = [];
  List<TextFieldUS> signUpTeacher = [];
  Map<String, String?> errorsTeacherUp = {};
  List<TextFieldUS> signIn = [];
  String? science;
  String? unknownError;
  List<ScienceModel> sciences = [];
  TextFieldUS nick = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.nick),
  );
  TextFieldUS password = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.password),
  );
  final key = GlobalKey<FormState>();
  final keyTeacherUp = GlobalKey<FormState>();

  LogInVM(this.context) {
    init();
  }

  Future<bool> logIn(String title) async {
    isLoading = true;
    print(title);
    notifyListeners();
    try {
      final res = await auth.signIn(
        nick.controller.text,
        password.controller.text,
        title == t.logInAsTeacher ? keys.teacher : keys.director,
      );
      if (res == null) {
        return true;
      } else if (res == def.unknownError) {
        loginErrors[h.password] = lan(def.unknownError);
        loginErrors[h.nick] = lan(def.unknownError);
      } else {
        if (res == myErrors.wrongPassword) {
          loginErrors[h.password] = lan(myErrors.wrongPassword);
        } else {
          loginErrors[h.password] = null;
        }
        if (res == myErrors.userNotFound) {
          loginErrors[h.nick] = lan(myErrors.userNotFound);
        } else {
          loginErrors[h.nick] = null;
        }
      }
    } catch (e) {
      print('logIn: $e');
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> signUpDirectorFunc() async {
    isLoading = true;
    notifyListeners();
    final school = SchoolModel(
      posts: [],
      id: 'id',
      sciences: [],
      laws: [],
      nick: signUpDirector[2].controller.text,
      receptionTime: [],
    );
    final detail = DetailDirectorModel(
      tel: [],
      nick: signUpDirector[0].controller.text,
      fullame: signUpDirector[1].controller.text,
      password: signUpDirector[3].controller.text,
      time: DateTime.now(),
    );
    final director = DirectorModel(
      posts: [],
      id: 'id',
      detail: detail,
    );
    final id = await auth.signUpDirector(director);
    director.id = id!;
    await fb.signUpDirector(director);
    await fb.createSchool(school);
    isLoading = false;
    notifyListeners();
  }

  Future<bool> signUpTeacherFunc(String code) async {
    isLoading = true;
    notifyListeners();
    if (!checkUpTeacher()) return false;
    GenerateModel generate = (await fb.getAllGenerate())
        .firstWhere((element) => element.code == code);
    DetailTeacherModel detail = DetailTeacherModel(
      time: DateTime.now(),
      bio: '',
      avatar: null,
      tel: [],
      fullname: signUpTeacher[1].controller.text,
      science: science!,
      nick: signUpTeacher[0].controller.text,
      password: signUpTeacher[2].controller.text,
    );
    TeacherModel teacher = TeacherModel(
      id: 'id',
      detail: detail,
      posts: [],
      centerId: generate.center,
    );
    var res = await auth.signUpTeacher(teacher);
    if (res == null) {
      unknownError = lan(def.unknownError);
    } else if (res == myErrors.weakPassword) {
      errorsTeacherUp[h.password] = lan(myErrors.weakPassword);
    } else if (res == myErrors.usedNick) {
      errorsTeacherUp[h.nick] = lan(myErrors.usedNick);
    } else if (res == myErrors.invalidNick) {
      errorsTeacherUp[h.nick] = lan(myErrors.invalidNick);
    } else {
      teacher.id = res;
      var r = await fb.signUpTeacher(teacher);
      if (r == def.unknownError) {
        unknownError = lan(def.unknownError);
      } else {
        await fb.deleteToken(
          GenerateModel(
            time: DateTime.now(),
            code: code,
            type: keys.teacher,
            center: generate.center,
          ),
        );
        return true;
      }
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  void initErrors() {
    errorsTeacherUp = {
      h.nick: null,
      h.name: null,
      h.password: null,
      h.science: null,
    };
    loginErrors = {
      h.password: null,
      h.nick: null,
    };
    notifyListeners();
  }

  bool checkUpTeacher() {
    bool isCan = true;
    if (signUpTeacher[1].controller.text.isEmpty) {
      errorsTeacherUp[h.name] = myErrors.nameRequired;
      isCan = false;
    } else {
      errorsTeacherUp[h.name] = null;
    }
    if (signUpTeacher[0].controller.text.isEmpty) {
      errorsTeacherUp[h.nick] = myErrors.nickRequired;
      isCan = false;
    } else {
      errorsTeacherUp[h.nick] = null;
    }
    if (signUpTeacher[2].controller.text.isEmpty) {
      errorsTeacherUp[h.password] = myErrors.passwordRequired;
      isCan = false;
    } else {
      errorsTeacherUp[h.password] = null;
    }
    if (science == null) {
      errorsTeacherUp[h.science] = myErrors.scienceRequired;
      isCan = false;
    } else {
      errorsTeacherUp[h.science] = null;
    }
    notifyListeners();
    return isCan;
  }

  void init() async {
    if (token != null) return;
    token = TextFieldUS(
      controller: TextEditingController(text: 'E2OoRrMQkR0tOKuYTIMM'),
      title: lan(t.token),
      key: key,
      validator: (val) {
        return 'null';
      },
    );
    checkToken = ButtonUS(
      title: lan(t.next),
      color: c.c6,
      onTap: () async {
        isLoading = true;
        notifyListeners();
        final data = await fb.checkToken(token!.controller.text);
        isLoading = false;
        notifyListeners();
        if (data == t.loginAsDirector) {
          title = data;
          error = null;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SignUpAsDirectorPage(),
            ),
          );
        } else if (data == t.logInAsTeacher) {
          title = data;
          error = null;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SignUpAsTeacherPage(
                code: token!.controller.text,
              ),
            ),
          );
        } else {
          title = null;
          error = data;
        }
        print(error);
        print(title);
        notifyListeners();
      },
    );

    signUpDirector = [
      TextFieldUS(
        controller: TextEditingController(),
        title: lan(h.nick),
      ),
      TextFieldUS(
        controller: TextEditingController(),
        title: lan(h.name),
      ),
      TextFieldUS(
        controller: TextEditingController(),
        title: lan(h.schoolName),
      ),
      TextFieldUS(
        controller: TextEditingController(),
        title: lan(h.password),
        isPassword: true,
      ),
    ];

    signUpTeacher = [
      TextFieldUS(
        controller: TextEditingController(),
        title: h.nick,
      ),
      TextFieldUS(
        controller: TextEditingController(),
        title: h.name,
      ),
      TextFieldUS(
        controller: TextEditingController(),
        title: h.password,
        isPassword: true,
      ),
    ];
    sciences = await fb.getAllSciences();
  }
}
