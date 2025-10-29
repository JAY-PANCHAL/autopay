class ReasonsModel {
  List<ReasonsModelData>? data;

  ReasonsModel({this.data});

  ReasonsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ReasonsModelData>[];
      json['data'].forEach((v) {
        data!.add(new ReasonsModelData.fromJson(v));
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

class ReasonsModelData {
  int? reasonCode;
  int? reasonType;
  String? reason;

  ReasonsModelData({this.reasonCode, this.reasonType, this.reason});

  ReasonsModelData.fromJson(Map<String, dynamic> json) {
    reasonCode = json['reason_code'];
    reasonType = json['reason_type'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reason_code'] = this.reasonCode;
    data['reason_type'] = this.reasonType;
    data['reason'] = this.reason;
    return data;
  }
}
