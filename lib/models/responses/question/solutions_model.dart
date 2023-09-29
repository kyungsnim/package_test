import 'package:package_test/_importer.dart';

class SolutionsModel {
  String? _comment;
  String? _code;
  String? _contentSolution;
  String? _editorSolution;
  List<SolutionKeywordsModel>? _solutionKeywords;
  List<DefineKeywordsModel>? _defineKeywords;
  List<OrganizeKeywordsModel>? _organizeKeywords;
  List<SolutionStepsModel>? _steps;

  SolutionsModel(
      {String? comment,
        String? code,
        String? contentSolution,
        String? editorSolution,
        List<SolutionKeywordsModel>? solutionKeywords,
        List<DefineKeywordsModel>? defineKeywords,
        List<OrganizeKeywordsModel>? organizeKeywords,
        List<SolutionStepsModel>? steps}) {
    if (comment != null) {
      _comment = comment;
    }
    if (code != null) {
      _code = code;
    }
    if (contentSolution != null) {
      _contentSolution = contentSolution;
    }
    if (editorSolution != null) {
      _editorSolution = editorSolution;
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

  String? get comment => _comment;
  String? get code => _code;
  String? get contentSolution => _contentSolution;
  String? get editorSolution => _editorSolution;
  List<SolutionKeywordsModel>? get solutionKeywords => _solutionKeywords;
  List<DefineKeywordsModel>? get defineKeywords => _defineKeywords;
  List<OrganizeKeywordsModel>? get organizeKeywords => _organizeKeywords;
  List<SolutionStepsModel>? get steps => _steps;

  SolutionsModel.fromJson(Map<String, dynamic> json) {
    _comment = json['comment'];
    _code = json['code'];
    _contentSolution = json['content_solution'];
    _editorSolution = json['editor_solution'];
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
      _steps = <SolutionStepsModel>[];
      json['steps'].forEach((v) {
        _steps!.add(SolutionStepsModel.fromJson(v));
      });
    }
  }
}