import 'package:package_test/_importer.dart';

class HintsModel {
  String? _code;
  String? _contentHint;
  String? _editorHint;
  List<SolutionKeywordsModel>? _solutionKeywords;
  List<DefineKeywordsModel>? _defineKeywords;
  List<OrganizeKeywordsModel>? _organizeKeywords;
  List<HintStepsModel>? _steps;

  HintsModel(
      {String? code,
        String? contentHint,
        String? editorHint,
        List<SolutionKeywordsModel>? solutionKeywords,
        List<DefineKeywordsModel>? defineKeywords,
        List<OrganizeKeywordsModel>? organizeKeywords,
        List<HintStepsModel>? steps}) {
    if (code != null) {
      _code = code;
    }
    if (contentHint != null) {
      _contentHint = contentHint;
    }
    if (editorHint != null) {
      _editorHint = editorHint;
    }
    if (solutionKeywords != null) {
      _solutionKeywords = solutionKeywords;
    }
    if (defineKeywords != null) {
      _defineKeywords = defineKeywords;
    }
    if (organizeKeywords != null) {
      _organizeKeywords = organizeKeywords;
    }
    if (steps != null) {
      _steps = steps;
    }
  }

  String? get code => _code;
  String? get contentHint => _contentHint;
  String? get editorHint => _editorHint;
  List<SolutionKeywordsModel>? get solutionKeywords => _solutionKeywords;
  List<DefineKeywordsModel>? get defineKeywords => _defineKeywords;
  List<OrganizeKeywordsModel>? get organizeKeywords => _organizeKeywords;
  List<HintStepsModel>? get steps => _steps;

  HintsModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _contentHint = json['content_hint'];
    _editorHint = json['editor_hint'];
    if (json['solution_keywords'] != null) {
      _solutionKeywords = <SolutionKeywordsModel>[];
      json['solution_keywords'].forEach((v) {
        _solutionKeywords!.add(SolutionKeywordsModel.fromJson(v));
      });
    }
    if (json['define_keywords'] != null) {
      _defineKeywords = <DefineKeywordsModel>[];
      json['define_keywords'].forEach((v) {
        _defineKeywords!.add(DefineKeywordsModel.fromJson(v));
      });
    }
    if (json['organize_keywords'] != null) {
      _organizeKeywords = <OrganizeKeywordsModel>[];
      json['organize_keywords'].forEach((v) {
        _organizeKeywords!.add(OrganizeKeywordsModel.fromJson(v));
      });
    }
    if (json['steps'] != null) {
      _steps = <HintStepsModel>[];
      json['steps'].forEach((v) {
        _steps!.add(HintStepsModel.fromJson(v));
      });
    }
  }
}