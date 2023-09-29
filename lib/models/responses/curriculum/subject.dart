class Subject {
  String? _title;
  int? _count;
  int? _progress;
  int? _achievement;

  Subject({String? title, int? count, int? progress, int? achievement}) {
    if (title != null) {
      _title = title;
    }
    if (count != null) {
      _count = count;
    }
    if (progress != null) {
      _progress = progress;
    }
    if (achievement != null) {
      _achievement = achievement;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  int? get count => _count;
  set count(int? count) => _count = count;
  int? get achievement => _achievement;
  int? get progress => _progress;
  set progress(int? progress) => _progress = progress;
  set achievement(int? achievement) => _achievement = achievement;

  Subject.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _count = json['count'];
    _progress = json['progress'];
    _achievement = json['achievement'];
  }
}