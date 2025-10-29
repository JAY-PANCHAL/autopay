class QCDetailsModel {
  List<QCDetailsModelData>? data;

  QCDetailsModel({this.data});

  QCDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <QCDetailsModelData>[];
      json['data'].forEach((v) {
        data!.add(new QCDetailsModelData.fromJson(v));
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

class QCDetailsModelData {
  int? qcParameterCode;
  String? title;

  QCDetailsModelData({this.qcParameterCode, this.title});

  QCDetailsModelData.fromJson(Map<String, dynamic> json) {
    qcParameterCode = json['qc_parameter_code'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qc_parameter_code'] = this.qcParameterCode;
    data['title'] = this.title;
    return data;
  }
}
