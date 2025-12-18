class LoginModel {
  int? success;
  Data? data;

  LoginModel({this.success, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  int? userId;
  int? partnerId;
  String? userName;
  String? email;
  bool? mobile;
  String? idNumber;

  Data(
      {this.message,
        this.userId,
        this.partnerId,
        this.userName,
        this.email,
        this.mobile,
        this.idNumber});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['user_id'];
    partnerId = json['partner_id'];
    userName = json['user_name'];
    email = json['email'];
    mobile = json['mobile'];
    idNumber = json['id_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['partner_id'] = this.partnerId;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['id_number'] = this.idNumber;
    return data;
  }
}
