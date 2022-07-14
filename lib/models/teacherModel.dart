class TeacherModel {
  String? name;
  String? subjectName;
  List? completedClasses;

  TeacherModel({this.name, this.subjectName, this.completedClasses});

  TeacherModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subjectName = json['subjectName'];
    completedClasses = json['completedClasses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['subjectName'] = this.subjectName;
    data['completedClasses'] = this.completedClasses;
    return data;
  }
}
