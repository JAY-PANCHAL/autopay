class BagListModel {
  List<BagListData>? data;

  BagListModel({this.data});

  BagListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BagListData>[];
      json['data'].forEach((v) {
        data!.add(new BagListData.fromJson(v));
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

class BagListData {
  int? isAccepted;
  int? priority;
  int? bagCode;
  int? wrkerQCInwardCode;
  String? bagNo;
  String? createdOn;
  int? isActive;
  BagListData(
      {this.isAccepted,
      this.priority,
      this.bagCode,
      this.wrkerQCInwardCode,
      this.bagNo,
        this.isActive,
      this.createdOn});

  BagListData.fromJson(Map<String, dynamic> json) {
    isAccepted = json['is_accepted'];
    priority = json['priority'];
    bagCode = json['bag_code'];
    wrkerQCInwardCode = json['WrkerQCInward_code'];
    bagNo = json['bag_no'];
    isActive=json['is_active'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_accepted'] = this.isAccepted;
    data['priority'] = this.priority;
    data['is_active']=this.isActive;
    data['bag_code'] = this.bagCode;
    data['WrkerQCInward_code'] = this.wrkerQCInwardCode;
    data['bag_no'] = this.bagNo;
    data['created_on'] = this.createdOn;
    return data;
  }

  @override
  String toString() {
    return 'BagListData(bagNo: $bagNo, priority: $priority, createdOn: $createdOn)';
  }
}
