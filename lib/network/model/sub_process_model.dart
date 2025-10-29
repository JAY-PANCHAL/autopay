class SubProcessModel {
  List<SubProcessModelData>? data;

  SubProcessModel({this.data});

  SubProcessModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SubProcessModelData>[];
      json['data'].forEach((v) {
        data!.add(new SubProcessModelData.fromJson(v));
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

class SubProcessModelData {
  int? userCode;
  int? subProcessCode;
  String? subProcessName;

  SubProcessModelData(
      {this.userCode, this.subProcessCode, this.subProcessName});

  SubProcessModelData.fromJson(Map<String, dynamic> json) {
    userCode = json['user_code'];
    subProcessCode = json['sub_process_code'];
    subProcessName = json['sub_process_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_code'] = this.userCode;
    data['sub_process_code'] = this.subProcessCode;
    data['sub_process_name'] = this.subProcessName;
    return data;
  }
}
