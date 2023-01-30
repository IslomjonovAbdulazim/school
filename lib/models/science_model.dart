class ScienceModel {
  late String name;
  late String des;
  late String id;

  ScienceModel({
    required this.name,
    required this.des,
    required this.id,
  });

  ScienceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    des = json['des'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'des': des,
        'id': id,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
