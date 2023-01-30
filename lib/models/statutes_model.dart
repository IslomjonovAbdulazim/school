class StatuteModel {
  late String title;
  late List<String> content;
  late String id;
  late DateTime time;

  StatuteModel({
    required this.content,
    required this.title,
    required this.id,
    required this.time,
  });

  StatuteModel.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content']);
    title = json['title'];
    id = json['id'];
    time = DateTime.parse(json['time']);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'title': title,
        'id': id,
        'time': time.toIso8601String(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
