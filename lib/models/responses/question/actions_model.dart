import 'package:package_test/_importer.dart';

class ActionsModel {
  String? _code;
  List<ActionStepsModel>? _steps;
  String? _createdAt;
  String? _updatedAt;

  ActionsModel(
      {String? code, List<ActionStepsModel>? steps, String? createdAt, String? updatedAt}) {
    if (code != null) {
      _code = code;
    }
    if (steps != null) {
      _steps = steps;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
  }

  String? get code => _code;
  List<ActionStepsModel>? get steps => _steps;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  ActionsModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    if (json['steps'] != null) {
      _steps = <ActionStepsModel>[];
      json['steps'].forEach((v) {
        _steps!.add(ActionStepsModel.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
}