import 'package:package_test/_importer.dart';

class MiddleUnit {
  String? _title;
  List<SmallUnit>? _smallUnit;

  MiddleUnit({String? title, List<SmallUnit>? smallUnit}) {
    if (title != null) {
      _title = title;
    }
    if (smallUnit != null) {
      _smallUnit = smallUnit;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  List<SmallUnit>? get smallUnit => _smallUnit;
  set smallUnit(List<SmallUnit>? smallUnit) => _smallUnit = smallUnit;

  MiddleUnit.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    if (json['smallUnit'] != null) {
      _smallUnit = <SmallUnit>[];
      json['smallUnit'].forEach((v) {
        _smallUnit!.add(SmallUnit.fromJson(v));
      });
    }
  }
}