class UserModel {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? dateOfJoin;
  String? address;
  String? profileImageName;
  List? course;
  String? id;
  String? token;

  UserModel(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.profileImageName,
      this.address,
      this.dateOfJoin,
      this.course,
      this.id,
      this.token});

  UserModel.fromJson(Map<String, Object?> json)
      : this(
            firstName: json['firstName']! as String,
            lastName: json['lastName']! as String,
            email: json['email']! as String,
            profileImageName: json['profileImageName'] as String,
            phoneNumber: json['phone']! as String,
            address: json['address'] as String,
            dateOfJoin: json['dateOfJoin'] as String,
            course: json['selectedCourse'] as List,
            id: json['id'] as String,
            token: json['token'] as String);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phoneNumber;
    data['email'] = this.email;
    data['profileImageName'] = this.profileImageName;
    data['address'] = this.address;
    data['dateOfJoin'] = this.dateOfJoin;
    data['selectedCourse'] = this.course;
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }
}
