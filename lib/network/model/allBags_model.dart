class AllBagsModel {
  String? bagCode;
  String? bagDate;
  String? bagTime;
  String? bagStatus;
  String? bagStyle;
  String? bagProcess;
  String? bagSubProcess;
  String? bagType;
  String? bagPriority;
  List<BagTimingModel>? bagTimingModel;

  AllBagsModel(
      {this.bagCode,
      this.bagDate,
      this.bagTime,
      this.bagStatus,
      this.bagStyle,
      this.bagProcess,
      this.bagSubProcess,
      this.bagType,
      this.bagPriority,
      this.bagTimingModel});

  AllBagsModel.fromJson(Map<String, dynamic> json) {
    bagCode = json['bagCode'];
    bagDate = json['bagDate'];
    bagTime = json['bagTime'];
    bagStatus = json['status_long_data'];
    bagStyle = json['status_date_time'];
    bagProcess = json['reason_code'];
    bagSubProcess = json['Reason_short_data'];
    bagType = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bag_code'] = this.bagCode;
    data['status_code'] = this.bagDate;
    data['Status_short_data'] = this.bagTime;
    data['status_long_data'] = this.bagStatus;
    data['status_date_time'] = this.bagStyle;
    data['reason_code'] = this.bagProcess;
    data['Reason_short_data'] = this.bagSubProcess;
    data['reason'] = this.bagType;
    return data;
  }
}

class BagTimingModel {
  String? bagStatus;
  String? bagTiming;
  String? reason;

  BagTimingModel({
    this.bagStatus,
    this.bagTiming,
    this.reason
  });
}
