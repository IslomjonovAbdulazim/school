import 'package:equatable/equatable.dart';

class GenerateModel extends Equatable {
  late String type;
  late String code;
  late DateTime time;
  String? entrancedId;
  DateTime? entrancedTime;
  late String center;

  GenerateModel({
    required this.time,
    required this.code,
    required this.type,
    this.entrancedId,
    this.entrancedTime,
    required this.center,
  });

  GenerateModel.fromJson(Map<String, dynamic> json) {
    time = DateTime.parse(json['time']);
    code = json['code'];
    type = json['type'];
    entrancedId = json['entrancedId'];
    entrancedTime = json['entrancedTime'] == null
        ? null
        : DateTime.parse(json['entrancedTime']);
    center = json['center'];
  }

  Map<String, dynamic> toJson() => {
        'time': time.toIso8601String(),
        'code': code,
        'type': type,
        'entrancedId': entrancedId,
        'entrancedTime': entrancedTime?.toIso8601String(),
        'center': center,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [code];
}
