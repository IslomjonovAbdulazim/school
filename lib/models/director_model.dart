import 'package:ds/models/post_model.dart';

class DirectorModel {
  late String id;
  late DetailDirectorModel detail;
  late List<String> posts;

  DirectorModel({
    required this.posts,
    required this.id,
    required this.detail,
  });

  DirectorModel.fromJson(Map<String, dynamic> json) {
    posts = List.from(json['posts']);
    id = json['id'];
    detail = DetailDirectorModel.fromJson(json['detail']);
  }

  Map<String, dynamic> toJson() => {
        'posts': posts,
        'id': id,
        'detail': detail.toJson(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class DetailDirectorModel {
  late String fullame;
  late List<String> tel;
  String? bio;
  BodyModel? avatar;
  late DateTime time;
  late String password;
  late String nick;

  DetailDirectorModel({
    required this.tel,
    this.bio,
    required this.fullame,
    this.avatar,
    required this.password,
    required this.time,
    required this.nick,
  });

  DetailDirectorModel.fromJson(Map<String, dynamic> json) {
    tel = List.from(json['tel']);
    bio = json['bio'];
    fullame = json['fullame'];
    avatar = json['avatar'] != null ? BodyModel.fromJson(json['avatar']) : null;
    nick = json['nick'];
    password = json['password'];
    time = DateTime.parse(json['time']);
  }

  Map<String, dynamic> toJson() => {
        'tel': tel,
        'bio': bio,
        'nick': nick,
        'fullame': fullame,
        'avatar': avatar?.toJson(),
        'password': password,
        'time': time.toIso8601String(),
      };
}
