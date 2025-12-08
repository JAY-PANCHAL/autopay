class TokenModel {
  int? success;
  Data? data;

  TokenModel({this.success, this.data});

  TokenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? uid;
  String? token;
  int? userType;
  String? expiresOn;

  Data({this.uid, this.token, this.userType, this.expiresOn});

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    token = json['token'];
    userType = json['user_type'];
    expiresOn = json['expires_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['token'] = this.token;
    data['user_type'] = this.userType;
    data['expires_on'] = this.expiresOn;
    return data;
  }
}
