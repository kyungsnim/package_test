class AnswersModel {
  int? _answerNo;
  String? _contentAnswer;
  String? _editorAnswer;
  String? _correctAnswer;
  bool? _isCorrect;
  String? _code;
  String? _questionCode;

  AnswersModel(
      {int? answerNo,
        String? contentAnswer,
        String? editorAnswer,
        String? correctAnswer,
        bool? isCorrect,
        String? code,
        String? questionCode}) {
    if (answerNo != null) {
      _answerNo = answerNo;
    }
    if (contentAnswer != null) {
      _contentAnswer = contentAnswer;
    }
    if (editorAnswer != null) {
      _editorAnswer = editorAnswer;
    }
    if (correctAnswer != null) {
      _correctAnswer = correctAnswer;
    }
    if (isCorrect != null) {
      _isCorrect = isCorrect;
    }
    if (code != null) {
      _code = code;
    }
    if (questionCode != null) {
      _questionCode = questionCode;
    }
  }

  int? get answerNo => _answerNo;
  String? get contentAnswer => _contentAnswer;
  String? get editorAnswer => _editorAnswer;
  String? get correctAnswer => _correctAnswer;
  bool? get isCorrect => _isCorrect;
  String? get code => _code;
  String? get questionCode => _questionCode;

  AnswersModel.fromJson(Map<String, dynamic> json) {
    _answerNo = json['answer_no'];
    _contentAnswer = json['content_answer'];
    _editorAnswer = json['editor_answer'];
    _correctAnswer = json['correct_answer'];
    _isCorrect = json['is_correct'];
    _code = json['code'];
    _questionCode = json['question_code'];
  }
}