class UserModel {
  String? id;
  String? full_name;
  String? email;
  String? password;
  String? profilePhoto;
  String? phoneNumber;
  String? address;
  String? role;

  UserModel(
      {this.id,
      this.full_name,
      this.email,
      this.password,
      this.profilePhoto,
      this.phoneNumber,
      this.address,
      this.role = "user"});

  UserModel.fromJson(this.id, Map<String, dynamic> json) {
    full_name = json['full_name'];
    email = json['email'];
    password = json['password'];
    profilePhoto = json['profile_photo'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = full_name;
    data['email'] = email;
    data['password'] = password;
    data['profile_photo'] = profilePhoto;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['role'] = role;
    return data;
  }
}
