class CommentModel {
  late String by;
  late String content;
  late DateTime time;
  String? replyId;

  CommentModel({
    required this.content,
    required this.time,
    required this.by,
    this.replyId,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    time = DateTime.parse(json['time']);
    by = json['by'];
    replyId = json['replyId'];
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'time': time.toIso8601String(),
        'by': by,
        'replyId': replyId,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
