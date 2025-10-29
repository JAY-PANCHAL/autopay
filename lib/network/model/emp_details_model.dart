/*class EmpDetailsModel {
  List<EmpDetailsModelData>? data;

  EmpDetailsModel({this.data});

  EmpDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EmpDetailsModelData>[];
      json['data'].forEach((v) {
        data!.add(new EmpDetailsModelData.fromJson(v));
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

class EmpDetailsModelData {
  int? userCode;
  String? userName;
  String? name;
  String? companyName;
  String? designation;
  String? workLocationName;
  String? category;
  String? skill;
  String? processName;
  String? subProcess;

  EmpDetailsModelData(
      {this.userCode,
      this.userName,
      this.name,
      this.companyName,
      this.designation,
      this.workLocationName,
      this.category,
      this.skill,
      this.processName,
      this.subProcess});

  EmpDetailsModelData.fromJson(Map<String, dynamic> json) {
    userCode = json['user_code'];
    userName = json['user_name'];
    name = json['Name'];
    companyName = json['company_name'];
    designation = json['designation'];
    workLocationName = json['work_location_name'];
    category = json['category'];
    skill = json['Skill'];
    processName = json['process_name'];
    subProcess = json['Sub_process'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_code'] = this.userCode;
    data['user_name'] = this.userName;
    data['Name'] = this.name;
    data['company_name'] = this.companyName;
    data['designation'] = this.designation;
    data['work_location_name'] = this.workLocationName;
    data['category'] = this.category;
    data['Skill'] = this.skill;
    data['process_name'] = this.processName;
    data['Sub_process'] = this.subProcess;
    return data;
  }
}*/
class EmpDetailsModel {
  List<EmpDetailsModelData>? data;

  EmpDetailsModel({this.data});

  EmpDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EmpDetailsModelData>[];
      json['data'].forEach((v) {
        data!.add(new EmpDetailsModelData.fromJson(v));
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

class EmpDetailsModelData {
  int? userCode;
  String? userName;
  String? name;
  String? companyName;
  String? designationName;
  String? locationName;
  String? roleName;
  String? skillName;

  EmpDetailsModelData(
      {this.userCode,
        this.userName,
        this.name,
        this.companyName,
        this.designationName,
        this.locationName,
        this.roleName,
        this.skillName});

  EmpDetailsModelData.fromJson(Map<String, dynamic> json) {
    userCode = json['user_code'];
    userName = json['user_name'];
    name = json['Name'];
    companyName = json['company_name'];
    designationName = json['designation_name'];
    locationName = json['location_name'];
    roleName = json['role_name'];
    skillName = json['skill_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_code'] = this.userCode;
    data['user_name'] = this.userName;
    data['Name'] = this.name;
    data['company_name'] = this.companyName;
    data['designation_name'] = this.designationName;
    data['location_name'] = this.locationName;
    data['role_name'] = this.roleName;
    data['skill_name'] = this.skillName;
    return data;
  }
}

