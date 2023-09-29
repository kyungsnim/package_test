class ReportModel {
  String? reportName;
  bool? isConfirmByParent;
  bool? isConfirmByUser;
  int? diagnosisScore;
  DateTime? createdAt;

  ReportModel({
    this.reportName,
    this.isConfirmByParent,
    this.isConfirmByUser,
    this.diagnosisScore,
    this.createdAt,
  });

  ReportModel.fromJson(Map<String, dynamic> json) {
    reportName = json['report_name'];
    isConfirmByParent = json['is_confirm_by_parent'];
    isConfirmByUser = json['is_confirm_by_user'];
    diagnosisScore = json['diagnosis_score'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['report_name'] = reportName;
    data['is_confirm_by_parent'] = isConfirmByParent;
    data['is_confirm_by_user'] = isConfirmByUser;
    data['diagnosis_score'] = diagnosisScore;
    data['created_at'] = createdAt;

    return data;
  }
}