class TimeModel {
  int? scdTime;
  bool? status;

  TimeModel({this.scdTime, this.status});

  TimeModel.fromJson(dynamic json) {
    scdTime = json['scdTime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['scdTime'] = scdTime;
    map['status'] = status;
    return map;
  }
}
