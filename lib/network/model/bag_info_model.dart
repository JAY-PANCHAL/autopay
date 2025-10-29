class BagInfoModel {
  List<BagInfoModelData>? bagInfo;
  List<BagActivityModelData>? bagActivity;

  BagInfoModel({this.bagInfo, this.bagActivity});

  BagInfoModel.fromJson(Map<String, dynamic> json) {
    if (json['bag_info'] != null) {
      bagInfo = <BagInfoModelData>[];
      json['bag_info'].forEach((v) {
        bagInfo!.add(BagInfoModelData.fromJson(v));
      });
    }
    if (json['bag_activity'] != null) {
      bagActivity = <BagActivityModelData>[];
      json['bag_activity'].forEach((v) {
        bagActivity!.add(BagActivityModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (bagInfo != null) {
      data['bag_info'] = bagInfo!.map((v) => v.toJson()).toList();
    }
    if (bagActivity != null) {
      data['bag_activity'] = bagActivity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BagInfoModelData {
  int? wrkerQCInwardCode;
  int? priority;
  int? isAccepted;
  String? styleNo;
  String? createdOn;
  int? qty;
  double? netWt;
  int? stnCount;
  String? imageUrl;
  double? stnCts;
  int? statusCode;

  BagInfoModelData({
    this.wrkerQCInwardCode,
    this.priority,
    this.isAccepted,
    this.styleNo,
    this.createdOn,
    this.qty,
    this.netWt,
    this.stnCount,
    this.imageUrl,
    this.stnCts,
    this.statusCode,
  });

  BagInfoModelData.fromJson(Map<String, dynamic> json) {
    wrkerQCInwardCode = json['WrkerQCInward_code'];
    priority = json['priority'];
    isAccepted = json['is_accepted'];
    styleNo = json['style_no'];
    createdOn = json['created_on'];
    qty = json['qty'];
    netWt = json['net_wt'];
    stnCount = json['stn_count'];
    imageUrl = json['image_url'];
    stnCts = json['stn_cts'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'WrkerQCInward_code': wrkerQCInwardCode,
      'priority': priority,
      'is_accepted': isAccepted,
      'style_no': styleNo,
      'created_on': createdOn,
      'qty': qty,
      'net_wt': netWt,
      'stn_count': stnCount,
      'image_url': imageUrl,
      'stn_cts': stnCts,
      'status_code': statusCode,
    };
  }
}

class BagActivityModelData {
  int? bagActivityCode;
  String? createdOn;
  String? status;
  String? subProcessName;
  String? reason;

  BagActivityModelData({
    this.bagActivityCode,
    this.createdOn,
    this.status,
    this.subProcessName,
    this.reason,
  });

  BagActivityModelData.fromJson(Map<String, dynamic> json) {
    bagActivityCode = json['bag_activity_code'];
    createdOn = json['created_on'];
    status = json['status'];
    subProcessName = json['sub_process_name'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    return {
      'bag_activity_code': bagActivityCode,
      'created_on': createdOn,
      'status': status,
      'sub_process_name': subProcessName,
      'reason': reason,
    };
  }

  @override
  String toString() {
    return 'BagActivityListData(bagActivityCode: $bagActivityCode, createdOn: $createdOn, status: $status, subProcessName: $subProcessName, reason: $reason)';
  }
}
