import 'dart:convert';

class CourseModel {
  String name;
  String time;

  CourseModel({
    required this.name,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'time': time,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      name: map['name'],
      time: map['time'],
    );
  }

  static List<CourseModel> fromMapList(List<dynamic> mapList) {
    List<CourseModel> list = [];

    mapList.forEach((element) {
      list.add(CourseModel.fromJson(element));
    });

    return list;
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
    CourseModel.fromMap(json.decode(source));
}