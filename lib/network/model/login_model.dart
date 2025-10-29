class LoginModel {
  List<Data>? data;

  LoginModel({this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? userCode;
  String? userName;
  String? password;
  int? sessioncode;
  String? token;
  String? finYearCode;
  String? locationCode;
  String? dbInstanceName;
  String? dbName;
  String? dbUserId;
  String? dbPassword;
  String? companyDbConfigCode;
  String? companyCode;
  String? message;

  Data(
      {this.userCode,
      this.userName,
      this.password,
      this.sessioncode,
      this.token,
      this.finYearCode,
      this.locationCode,
      this.dbInstanceName,
      this.dbName,
      this.dbUserId,
      this.dbPassword,
      this.companyDbConfigCode,
      this.companyCode,
      this.message});

  Data.fromJson(Map<String, dynamic> json) {
    userCode = json['user_code'];
    userName = json['user_name'];
    password = json['Password'];
    sessioncode = json['sessioncode'];
    token = json['Token'];
    finYearCode = json['FinYearCode'];
    locationCode = json['LocationCode'];
    dbInstanceName = json['db_instance_name'];
    dbName = json['db_name'];
    dbUserId = json['db_user_id'];
    dbPassword = json['db_password'];
    companyDbConfigCode = json['company_db_config_code'];
    companyCode = json['company_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_code'] = this.userCode;
    data['user_name'] = this.userName;
    data['Password'] = this.password;
    data['sessioncode'] = this.sessioncode;
    data['Token'] = this.token;
    data['FinYearCode'] = this.finYearCode;
    data['LocationCode'] = this.locationCode;
    data['db_instance_name'] = this.dbInstanceName;
    data['db_name'] = this.dbName;
    data['db_user_id'] = this.dbUserId;
    data['db_password'] = this.dbPassword;
    data['company_db_config_code'] = this.companyDbConfigCode;
    data['company_code'] = this.companyCode;
    data['message'] = this.message;
    return data;
  }
}
