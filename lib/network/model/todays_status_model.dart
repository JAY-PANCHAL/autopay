class TodaysStatusModel {
  List<Data>? data;

  TodaysStatusModel({this.data});

  TodaysStatusModel.fromJson(Map<String, dynamic> json) {
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
  String? totalTime;
  int? totalOutBags;
  int? totalOutGty;
  String? totalOutWeight;
  String? workStartTime;

  Data(
      {this.totalTime,
        this.totalOutBags,
        this.totalOutGty,
        this.totalOutWeight,
        this.workStartTime});

  Data.fromJson(Map<String, dynamic> json) {
    totalTime = json['total_time'];
    totalOutBags = json['total_out_bags'];
    totalOutGty = json['total_out_qty'];
    totalOutWeight = json['total_out_weight'];
    workStartTime = json['work_start_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_time'] = this.totalTime;
    data['total_out_bags'] = this.totalOutBags;
    data['total_out_qty'] = this.totalOutGty;
    data['total_out_weight'] = this.totalOutWeight;
    data['work_start_time'] = this.workStartTime;
    return data;
  }
}
