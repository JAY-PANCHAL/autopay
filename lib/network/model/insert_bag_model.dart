class InsertBagModel {
  List<InsertBagModel>? data;

  InsertBagModel({this.data});

  InsertBagModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <InsertBagModel>[];
      json['data'].forEach((v) {
        data!.add(new InsertBagModel.fromJson(v));
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

class InsertBagModelData {
  int? bagActivityCode;
  bool? isLocked;
  String? createdOn;
  int? insertSessionId;
  int? updateSessionId;
  bool? isDeleted;
  String? deletedOn;
  int? deletedBy;
  int? userCode;
  int? wrkerQCInwardCode;
  int? statusCode;
  String? statusDateTime;
  int? subProcessCode;
  int? workType;
  int? reasonCode;

  InsertBagModelData(
      {this.bagActivityCode,
      this.isLocked,
      this.createdOn,
      this.insertSessionId,
      this.updateSessionId,
      this.isDeleted,
      this.deletedOn,
      this.deletedBy,
      this.userCode,
      this.wrkerQCInwardCode,
      this.statusCode,
      this.statusDateTime,
      this.subProcessCode,
      this.workType,
      this.reasonCode});

  InsertBagModelData.fromJson(Map<String, dynamic> json) {
    bagActivityCode = json['bag_activity_code'];
    isLocked = json['is_locked'];
    createdOn = json['created_on'];
    insertSessionId = json['insert_session_id'];
    updateSessionId = json['update_session_id'];
    isDeleted = json['is_deleted'];
    deletedOn = json['deleted_on'];
    deletedBy = json['deleted_by'];
    userCode = json['user_code'];
    wrkerQCInwardCode = json['WrkerQCInward_code'];
    statusCode = json['status_code'];
    statusDateTime = json['status_date_time'];
    subProcessCode = json['sub_process_code'];
    workType = json['work_type'];
    reasonCode = json['reason_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bag_activity_code'] = this.bagActivityCode;
    data['is_locked'] = this.isLocked;
    data['created_on'] = this.createdOn;
    data['insert_session_id'] = this.insertSessionId;
    data['update_session_id'] = this.updateSessionId;
    data['is_deleted'] = this.isDeleted;
    data['deleted_on'] = this.deletedOn;
    data['deleted_by'] = this.deletedBy;
    data['user_code'] = this.userCode;
    data['WrkerQCInward_code'] = this.wrkerQCInwardCode;
    data['status_code'] = this.statusCode;
    data['status_date_time'] = this.statusDateTime;
    data['sub_process_code'] = this.subProcessCode;
    data['work_type'] = this.workType;
    data['reason_code'] = this.reasonCode;
    return data;
  }
}
