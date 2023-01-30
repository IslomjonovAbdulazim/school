import 'package:ds/models/post_model.dart';
import 'package:equatable/equatable.dart';
import 'statutes_model.dart';
import 'science_model.dart';

class SchoolModel {
  late List<PostModel> posts;
  late String id;
  PostModel? structure;
  SchoolBioModel? bio;
  late String nick;
  late List<ScienceModel> sciences;
  late List<StatuteModel> laws;
  late List<ReceptionTimeModel> receptionTime;

  SchoolModel({
    required this.posts,
    required this.id,
    this.structure,
    this.bio,
    required this.sciences,
    required this.laws,
    required this.nick,
    required this.receptionTime,
  });

  SchoolModel.fromJson(Map<String, dynamic> json) {
    posts = List.from(json['posts'])
        .map(
          (e) => PostModel.fromJson(e),
        )
        .toList();
    id = json['id'];
    structure = json['structure'] == null
        ? null
        : PostModel.fromJson(json['structure']);
    bio = json['bio'] == null ? null : SchoolBioModel.fromJson(json['bio']);
    sciences = List.from(json['sciences'])
        .map(
          (e) => ScienceModel.fromJson(e),
        )
        .toList();
    laws = List.from(json['laws'])
        .map(
          (e) => StatuteModel.fromJson(e),
        )
        .toList();
    nick = json['nick'];
    receptionTime = List.from(json['receptionTime'] ?? [])
        .map((e) => ReceptionTimeModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() => {
        'posts': posts.map((e) => e.toJson()).toList(),
        'id': id,
        'structure': structure?.toJson(),
        'bio': bio?.toJson(),
        'sciences': sciences.map((e) => e.toJson()).toList(),
        'laws': laws.map((e) => e.toJson()).toList(),
        'nick': nick,
        'receptionTime': receptionTime.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class SchoolBioModel {
  String? des;
  late List<BodyModel> images;
  late List<String> socialMedia;
  late List<String> tel;
  late Map<String, String> statistics;
  String? location;

  SchoolBioModel({
    required this.tel,
    this.des,
    this.location,
    required this.images,
    required this.socialMedia,
    required this.statistics,
  });

  SchoolBioModel.fromJson(Map<String, dynamic> json) {
    des = json['des'];
    images =
        List.from(json['images']).map((e) => BodyModel.fromJson(e)).toList();
    socialMedia = List.from(json['socialMedia']);
    tel = List.from(json['tel']);
    location = json['location'];
    statistics = Map.from(json['statistics']);
  }

  Map<String, dynamic> toJson() => {
        'des': des,
        'images': images.map((e) => e.toJson()).toList(),
        'socialMedia': socialMedia,
        'tel': tel,
        'location': location,
        'statistics': statistics,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class Deleted {
  late DateTime startTime;
  late DateTime endTime;
  late String des;

  Deleted({
    required this.des,
    required this.endTime,
    required this.startTime,
  });

  Deleted.fromJson(Map<String, dynamic> json) {
    des = json['des'];
    endTime = DateTime.parse(json['endTime']);
    startTime = DateTime.parse(json['startTime']);
  }

  Map<String, dynamic> toJson() => {
        'des': des,
        'endTime': endTime.toIso8601String(),
        'startTime': startTime.toIso8601String(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class ScheduleClassModel {
  late String id;
  late String des;
  late String grade;
  late DateTime time;
  late String classTeacher;
  late List<ScheduleDailyModel> schedules;

  ScheduleClassModel({
    required this.time,
    required this.id,
    required this.des,
    required this.classTeacher,
    required this.grade,
    required this.schedules,
  });

  ScheduleClassModel.fromJson(Map<String, dynamic> json) {
    time = DateTime.parse(json['time']);
    des = json['des'];
    id = json['id'];
    classTeacher = json['classTeacher'];
    grade = json['grade'];
    schedules = List.from(json['schedules'])
        .map((e) => ScheduleDailyModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() => {
        'time': time.toIso8601String(),
        'des': des,
        'id': id,
        'classTeacher': classTeacher,
        'grade': grade,
        'schedules': schedules.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class ScheduleDailyModel {
  late int day;

  // late DateTime overallEnd;
  // late DateTime overallStart;
  late List<ScheduleModel> schedules;

  ScheduleDailyModel({
    required this.day,
    required this.schedules,
    // required this.overallEnd,
    // required this.overallStart,
  });

  ScheduleDailyModel.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    // overallEnd = DateTime.parse(json['overallEnd']);
    // overallStart = DateTime.parse(json['overallStart']);
    schedules = List.from(json['schedules'])
        .map((e) => ScheduleModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        // 'overallEnd': overallEnd.toIso8601String(),
        // 'overallStart': overallStart.toIso8601String(),
        'schedules': schedules.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class ScheduleModel extends Equatable {
  late DateTime startTime;
  late DateTime endTime;
  late String science;
  late String teacher;
  late DateTime time;

  ScheduleModel({
    required this.endTime,
    required this.teacher,
    required this.science,
    required this.startTime,
    required this.time,
  });

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    endTime = DateTime.parse(json['endTime']);
    startTime = DateTime.parse(json['startTime']);
    teacher = json['teacher'];
    science = json['science'];
    time = DateTime.parse(json['time']);
  }

  Map<String, dynamic> toJson() => {
        'endTime': endTime.toIso8601String(),
        'startTime': startTime.toIso8601String(),
        'teacher': teacher,
        'science': science,
        'time': time.toIso8601String(),
      };

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [time];
}

class ReceptionTimeModel {
  late List<int> days;
  late DateTime start;
  late DateTime end;
  late String des;
  late DateTime time;

  ReceptionTimeModel({
    required this.days,
    required this.start,
    required this.end,
    required this.des,
    required this.time,
  });

  ReceptionTimeModel.fromJson(Map<String, dynamic> json) {
    days = List.from(json['days']);
    start = DateTime.parse(json['start']);
    end = DateTime.parse(json['end']);
    des = json['des'];
    time = DateTime.parse(json['time'] ?? DateTime.now().toIso8601String());
  }

  Map<String, dynamic> toJson() => {
        'days': days,
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
        'des': des,
        'time': time.toIso8601String(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
