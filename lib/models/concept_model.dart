class ConceptModel {
  String? level;
  String? name;
  String? bigSection;
  String? middleSection;
  String? subSection;

  ConceptModel({
    required this.level,
    required this.name,
    required this.bigSection,
    required this.middleSection,
    required this.subSection,
  });

  ConceptModel.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    name = json['name'];
    bigSection = json['big_section'] ?? '';
    middleSection = json['middle_section'] ?? '';
    subSection = json['sub_section'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level'] = level;
    data['name'] = name;
    data['big_section'] = bigSection;
    data['middle_section'] = middleSection;
    data['sub_section'] = subSection;

    return data;
  }
}