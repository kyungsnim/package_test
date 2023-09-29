import 'dart:ui';

class HeatmapModel {
  String? date;
  String? iconPath;
  String? timeTaken;
  String? title;
  String? subtitle;
  List<String>? stepList;
  int? stepIndex;
  int? progress;
  Color? progressColorDisabled;
  Color? progressColorEnabled;
  Color? stepColorDisabled;
  Color? stepColorEnabled;

  HeatmapModel({
    this.date,
    this.iconPath,
    this.timeTaken,
    this.title,
    this.subtitle,
    this.stepList,
    this.stepIndex,
    this.progress,
    this.progressColorDisabled,
    this.progressColorEnabled,
    this.stepColorDisabled,
    this.stepColorEnabled,
  });
}
