class UserModel {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? dateOfJoin;
  String? address;
  String? profileImageName;
  List? course;

  // String? address;

  UserModel(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.profileImageName,
      this.address,
        this.dateOfJoin,
      this.course});

  // UserModel fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //       firstName: json['firstName'],
  //       lastName: json['lastName'],
  //       age: json['age'],
  //       email: json['email'],
  //       profileImageUrl: json['profileImageUrl']);
  // }

  UserModel.fromJson(Map<String, Object?> json)
      : this(
            firstName: json['firstName']! as String,
            lastName: json['lastName']! as String,
            email: json['email']! as String,
            profileImageName: json['profileImageName'] as String,
            phoneNumber: json['phone']! as String,
            address: json['address'] as String,
            dateOfJoin: json['dateOfJoin'] as String,
            course: json['selectedCourse'] as List);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phoneNumber;
    data['email'] = this.email;
    data['profileImageName'] = this.profileImageName;
    data['address'] = this.address;
    data['dateOfJoin']=this.dateOfJoin;
    data['selectedCourse'] = this.course;
    return data;
  }
}
