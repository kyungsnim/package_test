import 'package:package_test/_importer.dart';

class ExamModel {
  int? _total;
  List<QuestionsModel>? _questionsModel;

  ExamModel({int? total, List<QuestionsModel>? questionsModel}) {
    if (total != null) {
      _total = total;
    }
    if (questionsModel != null) {
      _questionsModel = questionsModel;
    }
  }

  int? get total => _total;
  List<QuestionsModel>? get questionsModel => _questionsModel;

  ExamModel.fromJson(Map<String, dynamic> json) {
    _total = json['total'];
    if (json['questions'] != null) {
      _questionsModel = <QuestionsModel>[];
      json['questions'].forEach((v) {
        _questionsModel!.add(QuestionsModel.fromJson(v));
      });
    }
  }
}
