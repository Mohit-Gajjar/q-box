class UserModel {
  String? firstName;
  String? lastName;
  int? age;
  String? email;
  String? profileImageName;
  // String? address;

  UserModel(
      {this.firstName,
      this.lastName,
      this.age,
      this.email,
      this.profileImageName});

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
            age: json['age']! as int);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['age'] = this.age;
    data['email'] = this.email;
    data['profileImageName'] = this.profileImageName;
    return data;
  }
}
