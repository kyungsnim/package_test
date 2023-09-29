class ActionStepsModel {
  int? _step;
  String? _ttsScript;
  String? _contentScript;
  String? _editorScript;
  String? _contentAction;
  String? _editorAction;
  String? _code;
  String? _actionCode;
  String? _createdAt;
  String? _updatedAt;

  ActionStepsModel(
      {int? step,
        String? ttsScript,
        String? contentScript,
        String? editorScript,
        String? contentAction,
        String? editorAction,
        String? code,
        String? actionCode,
        String? createdAt,
        String? updatedAt}) {
    if (step != null) {
      _step = step;
    }
    if (ttsScript != null) {
      _ttsScript = ttsScript;
    }
    if (contentScript != null) {
      _contentScript = contentScript;
    }
    if (editorScript != null) {
      _editorScript = editorScript;
    }
    if (contentAction != null) {
      _contentAction = contentAction;
    }
    if (editorAction != null) {
      _editorAction = editorAction;
    }
    if (code != null) {
      _code = code;
    }
    if (actionCode != null) {
      _actionCode = actionCode;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
  }

  int? get step => _step;
  String? get ttsScript => _ttsScript;
  String? get contentScript => _contentScript;
  String? get editorScript => _editorScript;
  String? get contentAction => _contentAction;
  String? get editorAction => _editorAction;
  String? get code => _code;
  String? get actionCode => _actionCode;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  ActionStepsModel.fromJson(Map<String, dynamic> json) {
    _step = json['step'];
    _ttsScript = json['tts_script'];
    _contentScript = json['content_script'];
    _editorScript = json['editor_script'];
    _contentAction = json['content_action'];
    _editorAction = json['editor_action'];
    _code = json['code'];
    _actionCode = json['action_code'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
}