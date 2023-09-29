import 'package:package_test/_importer.dart';

class QuestionsModel {
  String? _code;
  String? _title;
  int? _difficulty;
  int? _solveTime;
  String? _questionType;
  String? _questionTypeName;
  String? _contentQuestion;
  String? _contentQuestionApp;
  String? _editorQuestion;
  String? _urlThumbnail;
  List<String>? _answersCorrect;
  List<AnswersModel>? _answers;
  List<SolutionsModel>? _solutions;
  List<HintsModel>? _hints;

  QuestionsModel(
      {String? code,
        String? title,
        int? difficulty,
        int? solveTime,
        String? questionType,
        String? questionTypeName,
        String? contentQuestion,
        String? contentQuestionApp,
        String? editorQuestion,
        List<String>? answersCorrect,
        List<AnswersModel>? answers,
        List<SolutionsModel>? solutions,
        List<HintsModel>? hints,
    }) {
    if (code != null) {
      _code = code;
    }
    if (title != null) {
      _title = title;
    }
    if (difficulty != null) {
      _difficulty = difficulty;
    }
    if (solveTime != null) {
      _solveTime = solveTime;
    }
    if (questionType != null) {
      _questionType = questionType;
    }
    if (questionTypeName != null) {
      _questionTypeName = questionTypeName;
    }
    if (contentQuestion != null) {
      _contentQuestion = contentQuestion;
    }
    if (contentQuestion != null) {
      _contentQuestionApp = contentQuestionApp;
    }
    if (editorQuestion != null) {
      _editorQuestion = editorQuestion;
    }
    if (answersCorrect != null) {
      _answersCorrect = answersCorrect;
    }
    if (answers != null) {
      _answers = answers;
    }
    if (solutions != null) {
      _solutions = solutions;
    }
    if (hints != null) {
      _hints = hints;
    }
    if (urlThumbnail != null) {
      _urlThumbnail = urlThumbnail;
    }
  }

  String? get code => _code;
  String? get title => _title;
  int? get difficulty => _difficulty;
  int? get solveTime => _solveTime;
  String? get questionType => _questionType;
  String? get questionTypeName => _questionTypeName;
  String? get contentQuestion => _contentQuestion;
  String? get contentQuestionApp => _contentQuestionApp;
  String? get editorQuestion => _editorQuestion;
  String? get urlThumbnail => _urlThumbnail;
  List<String>? get answersCorrect => _answersCorrect;
  List<AnswersModel>? get answers => _answers;
  List<SolutionsModel>? get solutions => _solutions;
  List<HintsModel>? get hints => _hints;

  QuestionsModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _title = json['title'];
    _difficulty = json['difficulty'];
    _solveTime = json['solve_time'];
    _questionType = json['question_type'];
    _questionTypeName = json['question_type_name'];
    _contentQuestion = json['content_question'];
    _contentQuestionApp = json['content_question_app'];
    _editorQuestion = json['editor_question'];
    _urlThumbnail = json['url_thumbnail'];
    if (json['answers_correct'] != null) {
      _answersCorrect = [];
      json['answers_correct'].forEach((v) {
        _answersCorrect!.add(v);
      });
    }
    if (json['answers'] != null) {
      _answers = <AnswersModel>[];
      json['answers'].forEach((v) {
        _answers!.add(AnswersModel.fromJson(v));
      });
    }
    if (json['solutions'] != null) {
      _solutions = <SolutionsModel>[];
      json['solutions'].forEach((v) {
        _solutions!.add(SolutionsModel.fromJson(v));
      });
    }
    if (json['hints'] != null) {
      _hints = <HintsModel>[];
      json['hints'].forEach((v) {
        _hints!.add(HintsModel.fromJson(v));
      });
    }
  }
}