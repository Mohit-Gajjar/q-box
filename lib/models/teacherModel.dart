class TeacherModel {
  String? name;
  // String? subjectName;
  String? profilePicUrl;
  List? completedClasses;
  String? email;

  TeacherModel(
      {this.name,
        this.profilePicUrl,
        this.completedClasses,this.email});

  TeacherModel.fromJson(Map<String, dynamic> json) {
    name = json['firstName'];
    // subjectName = json['subjectName'];
    profilePicUrl = json['profilePicUrl'];
    email = json['email'];
    completedClasses = json['completedClasses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email']=this.email;
    data['completedClasses'] = this.completedClasses;
    data['profilePicUrl']=this.profilePicUrl;
    return data;
  }
}
