import 'package:package_test/_importer.dart';

class SolutionStepsModel {
  String? _code;
  int? _step;
  String? _comment;
  String? _contentSolution;
  String? _editorSolution;
  List<ActionsModel>? _actions;

  SolutionStepsModel(
      {String? code,
        int? step,
        String? comment,
        String? contentSolution,
        String? editorSolution,
        List<SolutionKeywordsModel>? solutionKeywords,
        List<TheoryKeywordsModel>? theoryKeywords}) {
    if (code != null) {
      _code = code;
    }
    if (step != null) {
      _step = step;
    }
    if (comment != null) {
      _comment = comment;
    }
    if (contentSolution != null) {
      _contentSolution = contentSolution;
    }
    if (editorSolution != null) {
      _editorSolution = editorSolution;
    }
    if (actions != null) {
      _actions = actions;
    }
  }

  String? get code => _code;
  int? get step => _step;
  String? get comment => _comment;
  String? get contentSolution => _contentSolution;
  String? get editorSolution => _editorSolution;
  List<ActionsModel>? get actions => _actions;

  SolutionStepsModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _step = json['step'];
    _comment = json['comment'];
    _contentSolution = json['content_solution'];
    _editorSolution = json['editor_solution'];

    if (json['actions'] != null) {
      _actions = <ActionsModel>[];
      json['actions'].forEach((v) {
        _actions!.add(ActionsModel.fromJson(v));
      });
    }
  }
}