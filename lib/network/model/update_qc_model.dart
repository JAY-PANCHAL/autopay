class UpdateQCModel {
  List<Data>? data;

  UpdateQCModel({this.data});

  UpdateQCModel.fromJson(Map<String, dynamic> json) {
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
  int? wrkerQCTranscode;
  bool? isLocked;
  String? createdOn;
  int? insertSessionId;
  Null? updateSessionId;
  bool? isDeleted;
  Null? deletedOn;
  Null? deletedBy;
  int? wrkerQCInwardCode;
  int? qcParameterCode;
  bool? status;

  Data(
      {this.wrkerQCTranscode,
      this.isLocked,
      this.createdOn,
      this.insertSessionId,
      this.updateSessionId,
      this.isDeleted,
      this.deletedOn,
      this.deletedBy,
      this.wrkerQCInwardCode,
      this.qcParameterCode,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    wrkerQCTranscode = json['WrkerQCTranscode'];
    isLocked = json['is_locked'];
    createdOn = json['created_on'];
    insertSessionId = json['insert_session_id'];
    updateSessionId = json['update_session_id'];
    isDeleted = json['is_deleted'];
    deletedOn = json['deleted_on'];
    deletedBy = json['deleted_by'];
    wrkerQCInwardCode = json['WrkerQCInward_code'];
    qcParameterCode = json['qc_parameter_code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WrkerQCTranscode'] = this.wrkerQCTranscode;
    data['is_locked'] = this.isLocked;
    data['created_on'] = this.createdOn;
    data['insert_session_id'] = this.insertSessionId;
    data['update_session_id'] = this.updateSessionId;
    data['is_deleted'] = this.isDeleted;
    data['deleted_on'] = this.deletedOn;
    data['deleted_by'] = this.deletedBy;
    data['WrkerQCInward_code'] = this.wrkerQCInwardCode;
    data['qc_parameter_code'] = this.qcParameterCode;
    data['status'] = this.status;
    return data;
  }
}
