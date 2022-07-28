class UserDetailsModel {
  String? sId;
  String? userName;
  String? userEmail;
  String? userPhoneNumber;
  String? userImage;

  UserDetailsModel(
      {this.sId,
      this.userName,
      this.userEmail,
      this.userPhoneNumber,
      this.userImage});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhoneNumber = json['user_phone_number'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_phone_number'] = this.userPhoneNumber;
    data['user_image'] = this.userImage;
    return data;
  }
}
