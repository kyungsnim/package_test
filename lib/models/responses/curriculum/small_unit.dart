import 'package:package_test/_importer.dart';

class SmallUnit {
  String? _title;
  List<Subject>? _subject;

  SmallUnit({String? title, List<Subject>? subject}) {
    if (title != null) {
      _title = title;
    }
    if (subject != null) {
      _subject = subject;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  List<Subject>? get subject => _subject;
  set subject(List<Subject>? subject) => _subject = subject;

  SmallUnit.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _subject = <Subject>[];
    json['subject'].forEach((v) {
      _subject!.add(Subject.fromJson(v));
    });
  }
}