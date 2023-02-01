import 'package:bio_trap/model/body/time_model.dart';

class UpdateTrapModel {
  UpdateTrapModel({
      this.name, 
      this.serialNumber, 
      // this.isWorking,
      this.status, 
      this.iema, 
      this.valveQut, 
      this.fan, 
      this.isCounterOn, 
      this.isCounterReadingFromSimCard, 
      this.readingDate, 
      this.lat, 
      this.long, 
      this.trapFanSchedules, 
      this.trapValveQntSchedules, 
      this.trapCounterSchedules,});

  UpdateTrapModel.fromJson(dynamic json) {
    name = json['Name'];
    serialNumber = json['SerialNumber'];
    // isWorking = json['IsWorking'];
    status = json['Status'];
    iema = json['Iema'];
    valveQut = json['ValveQut'];
    fan = json['Fan'];
    isCounterOn = json['IsCounterOn'];
    isCounterReadingFromSimCard = json['IsCounterReadingFromSimCard'];
    readingDate = json['ReadingDate'];
    lat = json['Lat'];
    long = json['Long'];
    if (json['TrapFanSchedules'] != null) {
      trapFanSchedules = [];
      json['TrapFanSchedules'].forEach((v) {
        trapFanSchedules?.add(TimeModel.fromJson(v));
      });
    }
    if (json['TrapValveQntSchedules'] != null) {
      trapValveQntSchedules = [];
      json['TrapValveQntSchedules'].forEach((v) {
        trapValveQntSchedules?.add(TimeModel.fromJson(v));
      });
    }
    if (json['TrapCounterSchedules'] != null) {
      trapCounterSchedules = [];
      json['TrapCounterSchedules'].forEach((v) {
        trapCounterSchedules?.add(TimeModel.fromJson(v));
      });
    }
  }
  String? name;
  String? serialNumber;
  // bool? isWorking;
  int? status;
  int? iema;
  String? valveQut;
  String? fan;
  bool? isCounterOn;
  bool? isCounterReadingFromSimCard;
  String? readingDate;
  String? lat;
  String? long;
  List<TimeModel>? trapFanSchedules;
  List<TimeModel>? trapValveQntSchedules;
  List<TimeModel>? trapCounterSchedules;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = name;
    map['SerialNumber'] = serialNumber;
    // map['IsWorking'] = isWorking;
    map['Status'] = status;
    map['Iema'] = iema;
    map['ValveQut'] = valveQut;
    map['Fan'] = fan;
    map['IsCounterOn'] = isCounterOn;
    map['IsCounterReadingFromSimCard'] = isCounterReadingFromSimCard;
    map['ReadingDate'] = readingDate;
    map['Lat'] = lat;
    map['Long'] = long;
    if (trapFanSchedules != null) {
      map['TrapFanSchedules'] = trapFanSchedules?.map((v) => v.toJson()).toList();
    }
    if (trapValveQntSchedules != null) {
      map['TrapValveQntSchedules'] = trapValveQntSchedules?.map((v) => v.toJson()).toList();
    }
    if (trapCounterSchedules != null) {
      map['TrapCounterSchedules'] = trapCounterSchedules?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TrapCounterSchedules {
  TrapCounterSchedules({
      this.scdTime, 
      this.status,});

  TrapCounterSchedules.fromJson(dynamic json) {
    scdTime = json['scdTime'];
    status = json['status'];
  }
  int? scdTime;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['scdTime'] = scdTime;
    map['status'] = status;
    return map;
  }

}

class TrapValveQntSchedules {
  TrapValveQntSchedules({
      this.scdTime, 
      this.status,});

  TrapValveQntSchedules.fromJson(dynamic json) {
    scdTime = json['scdTime'];
    status = json['status'];
  }
  int? scdTime;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['scdTime'] = scdTime;
    map['status'] = status;
    return map;
  }

}

class TrapFanSchedules {
  TrapFanSchedules({
      this.scdTime, 
      this.status,});

  TrapFanSchedules.fromJson(dynamic json) {
    scdTime = json['scdTime'];
    status = json['status'];
  }
  int? scdTime;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['scdTime'] = scdTime;
    map['status'] = status;
    return map;
  }

}