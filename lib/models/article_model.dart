class ArticleModel {
  late String id;
  late String byId;
  late String articleName;
  late DateTime time;
  late List<MediaModel> media;
  late List<DesModel> des;
  late List<LinkModel> links;
  late List<TableModel> tables;

  ArticleModel({
    required this.byId,
    required this.id,
    required this.des,
    required this.time,
    required this.media,
    required this.links,
    required this.tables,
    required this.articleName,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    byId = json['byId'];
    id = json['id'];
    des = List.from(json['des']).map((e) => DesModel.fromJson(e)).toList();
    time = DateTime.parse(json['des']);
    media =
        List.from(json['media']).map((e) => MediaModel.fromJson(e)).toList();
    links = List.from(json['links']).map((e) => LinkModel.fromJson(e)).toList();
    tables =
        List.from(json['tables']).map((e) => TableModel.fromJson(e)).toList();
    articleName = json['articleName'];
  }

  Map<String, dynamic> toJson() => {
        'byId': byId,
        'id': id,
        'des': des.map((e) => e.toJson()).toList(),
        'time': time.toIso8601String(),
        'media': media.map((e) => e.toJson()).toList(),
        'links': links.map((e) => e.toJson()).toList(),
        'tables': tables.map((e) => e.toJson()).toList(),
        'articleName': articleName,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class TitleModel {
  late String title;
  late int index;

  TitleModel({
    required this.title,
    required this.index,
  });

  TitleModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'index': index,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class TableModel {
  late List<String> rowsTitle;
  late List<List<String>> data;
  late int index;

  TableModel({
    required this.index,
    required this.data,
    required this.rowsTitle,
  });

  TableModel.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    data = List.from(json['data'])
        .map((e) => List<String>.from(e).toList())
        .toList();
    rowsTitle = List<String>.from(json['rowsTitle']);
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'data': data,
        'rowsTitle': rowsTitle,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class LinkModel {
  late String index;
  late String link;
  late String title;

  LinkModel({
    required this.index,
    required this.link,
    required this.title,
  });

  LinkModel.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    link = json['link'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'link': link,
        'title': title,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class DesModel {
  late int index;
  late String content;

  DesModel({
    required this.content,
    required this.index,
  });

  DesModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'index': index,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class MediaModel {
  late String path;
  late int index;
  bool isUploaded = false;
  late String deletePath;
  late double height;
  late double width;
  double ratio = 16 / 9;
  late String des;

  MediaModel({
    required this.deletePath,
    required this.index,
    required this.path,
    required this.width,
    required this.height,
    this.isUploaded = true,
    this.des = '',
  }) {
    ratio = width / height;
  }

  MediaModel.fromJson(Map<String, dynamic> json) {
    deletePath = json['deletePath'];
    index = json['index'];
    path = json['path'];
    height = json['height'];
    width = json['width'];
    ratio = width / height;
    des = json['des'];
  }

  Map<String, dynamic> toJson() => {
        'deletePath': deletePath,
        'index': index,
        'path': path,
        'height': height,
        'width': width,
        'des': des,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
