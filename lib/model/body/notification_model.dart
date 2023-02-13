class NotificationModel {
  NotificationModel({
      this.changedDistance, 
      this.trapName, 
      this.dateTime,});

  NotificationModel.fromJson(dynamic json) {
    changedDistance = json['changedDistance'];
    trapName = json['trapName'];
    dateTime = json['dateTime'];
  }
  double? changedDistance;
  String? trapName;
  String? dateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['changedDistance'] = changedDistance;
    map['trapName'] = trapName;
    map['dateTime'] = dateTime;
    return map;
  }

}