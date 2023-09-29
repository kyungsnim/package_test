import 'package:package_test/_importer.dart';

class BigUnit {
  String? _title;
  List<MiddleUnit>? _middleUnit;

  BigUnit({String? title, List<MiddleUnit>? middleUnit}) {
    if (title != null) {
      _title = title;
    }
    if (middleUnit != null) {
      _middleUnit = middleUnit;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  List<MiddleUnit>? get middleUnit => _middleUnit;
  set middleUnit(List<MiddleUnit>? middleUnit) => _middleUnit = middleUnit;

  BigUnit.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    if (json['middleUnit'] != null) {
      _middleUnit = <MiddleUnit>[];
      json['middleUnit'].forEach((v) {
        _middleUnit!.add(MiddleUnit.fromJson(v));
      });
    }
  }
}