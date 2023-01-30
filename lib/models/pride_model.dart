import 'package:ds/models/post_model.dart';

class PrideModel {
  late String id;
  late String fullname;
  late String why;
  late List<BodyModel> media;
  late DateTime time;
   double maxRatio = 10;
  int index = 0;

  PrideModel({
    required this.fullname,
    required this.time,
    required this.media,
    required this.why,
    required this.id,
    this.index = 0,
  }) {
    for (var i in media) {
      if (i.width / i.height > maxRatio) {
        maxRatio = i.width / i.height;
      }
    }
  }

  PrideModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    id = json['id'];
    time = DateTime.parse(json['time']);
    media = List.from(json['media'])
        .map(
          (e) => BodyModel.fromJson(e),
        )
        .toList();
    index = 0;
    why = json['why'];
    for (var i in media) {
      if (i.width / i.height < maxRatio) {
        maxRatio = i.width / i.height;
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'fullname': fullname,
        'time': time.toIso8601String(),
        'id': id,
        'media': media.map((e) => e.toJson()).toList(),
        'why': why,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
