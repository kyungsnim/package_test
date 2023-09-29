import 'package:package_test/_importer.dart';

class HintStepsModel {
  String? _code;
  int? _step;
  String? _title;
  String? _contentHint;
  String? _editorHint;
  List<ActionsModel>? _actions;

  HintStepsModel(
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
      _title = comment;
    }
    if (contentSolution != null) {
      _contentHint = contentSolution;
    }
    if (editorSolution != null) {
      _editorHint = editorSolution;
    }
    if (actions != null) {
      _actions = actions;
    }
  }

  String? get code => _code;
  int? get step => _step;
  String? get title => _title;
  String? get contentHint => _contentHint;
  String? get editorHint => _editorHint;
  List<ActionsModel>? get actions => _actions;

  HintStepsModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _step = json['step'];
    _title = json['title'];
    _contentHint = json['content_hint'];
    _editorHint = json['editor_hint'];

    if (json['actions'] != null) {
      _actions = <ActionsModel>[];
      json['actions'].forEach((v) {
        _actions!.add(ActionsModel.fromJson(v));
      });
    }
  }
}