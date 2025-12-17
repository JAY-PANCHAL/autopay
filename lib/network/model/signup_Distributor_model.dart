class SignupDistibutorModel {
  int? success;
  Data? data;

  SignupDistibutorModel({this.success, this.data});

  SignupDistibutorModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? userIdCustom;
  String? userType;
  String? mobile;
  String? whatsappNumber;
  String? city;
  String? stateName;
  String? countryName;

  Data(
      {this.message,
        this.userId,
        this.name,
        this.email,
        this.userIdCustom,
        this.userType,
        this.mobile,
        this.whatsappNumber,
        this.city,
        this.stateName,
        this.countryName});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    userIdCustom = json['user_id_custom'];
    userType = json['user_type'];
    mobile = json['mobile'];
    whatsappNumber = json['whatsapp_number'];
    city = json['city'];
    stateName = json['state_name'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['user_id_custom'] = this.userIdCustom;
    data['user_type'] = this.userType;
    data['mobile'] = this.mobile;
    data['whatsapp_number'] = this.whatsappNumber;
    data['city'] = this.city;
    data['state_name'] = this.stateName;
    data['country_name'] = this.countryName;
    return data;
  }
}
