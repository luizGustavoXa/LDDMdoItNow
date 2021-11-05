import 'dart:convert';

class SubjectModel {
  String? disciplina;
  String? curso;
  String? nota;

  SubjectModel({
    required this.disciplina,
    required this.curso,
    required this.nota
  });

  Map<String, dynamic> toMap() {
    return {
      'disciplina': disciplina,
      'curso': curso,
      'nota': nota,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      disciplina: map['disciplina'],
      curso: map['curso'],
      nota: map['nota'],
    );
  }

  static List<SubjectModel> fromMapList(List<dynamic> mapList) {
    List<SubjectModel> list = [];

    mapList.forEach((element) {
      list.add(SubjectModel.fromJson(element));
    });

    return list;
  }

  String toJson() => json.encode(toMap());

  factory SubjectModel.fromJson(String source) =>
      SubjectModel.fromMap(json.decode(source));

}