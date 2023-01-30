import 'package:ds/models/post_model.dart';

class TeacherModel {
  late String id;
  late DetailTeacherModel detail;
  late List<String> posts;
  late String centerId;

  TeacherModel({
    required this.id,
    required this.detail,
    required this.posts,
    required this.centerId,
  });

  TeacherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    detail = DetailTeacherModel.fromJson(json['detail']);
    posts = List.from(json['posts']);
    centerId = json['centerId'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'detail': detail.toJson(),
        'posts': posts,
        'centerId': centerId,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class DetailTeacherModel {
  late String fullname;
  late List<String> tel;
  String? bio;
  BodyModel? avatar;
  late String science;
  late String nick;
  late String password;
  late DateTime time;

  DetailTeacherModel({
    required this.bio,
    required this.avatar,
    required this.tel,
    required this.fullname,
    required this.science,
    required this.nick,
    required this.password,
    required this.time,
  });

  DetailTeacherModel.fromJson(Map<String, dynamic> json) {
    bio = json['bio'];
    avatar = json['avatar'] == null ? null : BodyModel.fromJson(json['avatar']);
    tel = List.from(json['tel']);
    fullname = json['fullname'];
    science = json['science'];
    nick = json['nick'];
    password = json['password'];
    time = DateTime.parse(json['time'] ?? DateTime.now().toIso8601String());
  }

  Map<String, dynamic> toJson() => {
        'bio': bio,
        'avatar': avatar?.toJson(),
        'tel': tel,
        'fullname': fullname,
        'science': science,
        'nick': nick,
        'password': password,
        'time': time.toIso8601String(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
