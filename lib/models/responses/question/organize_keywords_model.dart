class OrganizeKeywordsModel {
  String? _title;
  String? _urlVideo;
  String? _code;
  bool? _isActive;
  String? _createdAt;

  OrganizeKeywordsModel(
      {String? title,
        String? urlVideo,
        String? code,
        bool? isActive,
        String? createdAt}) {
    if (title != null) {
      _title = title;
    }
    if (urlVideo != null) {
      _urlVideo = urlVideo;
    }
    if (code != null) {
      _code = code;
    }
    if (isActive != null) {
      _isActive = isActive;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
  }

  String? get title => _title;
  String? get urlVideo => _urlVideo;
  String? get code => _code;
  bool? get isActive => _isActive;
  String? get createdAt => _createdAt;

  OrganizeKeywordsModel.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _urlVideo = json['url_video'];
    _code = json['code'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
  }
}