import 'package:ds/models/comment_model.dart';
import 'package:equatable/equatable.dart';

class PostModel {
  late String title;
  late String content;
  late List<BodyModel> body;
  late List<CommentModel> comments; //
  late List<String> watched;
  late List<String> liked;
  late String id;
  late String byId;
  late DateTime time;
  String? science;
  int index = 0;
  double maxRatio = 10;

  PostModel({
    required this.content,
    required this.title,
    required this.body,
    required this.comments,
    required this.liked,
    required this.watched,
    required this.id,
    required this.byId,
    required this.time,
    this.index = 0,
    this.science,
  }) {
    for (var i in body) {
      if (i.width / i.height > maxRatio) {
        maxRatio = i.width / i.height;
      }
    }
  }

  PostModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    title = json['title'];
    body = List.from(json['body']).map((e) => BodyModel.fromJson(e)).toList();
    comments = List.from(List.from(json['comments']))
        .map(
          (e) => CommentModel.fromJson(e),
        )
        .toList();
    liked = List.from(json['liked']);
    watched = List.from(json['watched']);
    id = json['id'];
    byId = json['byId'];
    time = DateTime.parse(json['time']);
    index = 0;
    science = json['science'];
    for (var i in body) {
      if (i.width / i.height < maxRatio) {
        maxRatio = i.width / i.height;
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'title': title,
        'body': body.map((e) => e.toJson()).toList(),
        'comments': comments.map((e) => e.toJson()).toList(),
        'liked': liked,
        'watched': watched,
        'id': id,
        'time': time.toIso8601String(),
        'byId': byId,
        'science': science,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class BodyModel extends Equatable {
  late String path;
  late double height;
  late bool isImage;
  late String deletePath;
  late double width;
  bool? isUploaded;

  BodyModel({
    required this.height,
    required this.isImage,
    required this.path,
    required this.width,
    required this.deletePath,
    this.isUploaded = true,
  });

  BodyModel.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    isImage = json['isImage'];
    path = json['path'];
    width = json['width'];
    deletePath = json['deletePath'] ?? '';
  }

  Map<String, dynamic> toJson() => {
        'height': height,
        'isImage': isImage,
        'path': path,
        'width': width,
        'deletePath': deletePath,
      };

  @override
  String toString() {
    return toJson.toString();
  }

  @override
  List<Object?> get props => [path];
}
