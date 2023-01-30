class CommandModel {
  late String byId;
  late String toId;
  late int priority;
  late String title;
  late String content;
  late DateTime time;

  CommandModel({
    required this.time,
    required this.content,
    required this.byId,
    required this.title,
    required this.priority,
    required this.toId,
  });

  CommandModel.fromJson(Map<String, dynamic> json) {
    byId = json['byId'];
    toId = json['toId'];
    priority = json['priority'];
    title = json['title'];
    content = json['content'];
    time = DateTime.parse(json['time']);
  }

  Map<String, dynamic> toJson() => {
        'byId': byId,
        'toId': toId,
        'priority': priority,
        'title': title,
        'content': content,
        'time': time.toIso8601String(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
