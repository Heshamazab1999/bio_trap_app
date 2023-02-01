class TrapModel {
  TrapModel({
    this.id,
    this.name,
    this.serialNumber,
    this.isWorking,
    this.status,
    this.iema,
    this.valveQut,
    this.fan,
    this.isCounterOn,
    this.isCounterReadingFromSimCard,
    this.readingDate,
    this.lat,
    this.long,
    this.isScheduleOn,
    this.trapEmergencies,
    this.trapCounterSchedules,
    this.trapFanSchedules,
    this.trapValveQutSchedules,
  });

  TrapModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    serialNumber = json['serialNumber'];
    isWorking = json['isWorking'];
    status = json['status'];
    iema = json['iema'];
    valveQut = json['valveQut'];
    fan = json['fan'];
    isCounterOn = json['isCounterOn'];
    isCounterReadingFromSimCard = json['isCounterReadingFromSimCard'];
    readingDate = json['readingDate'];
    lat = json['lat'];
    long = json['long'];
    isScheduleOn = json['isScheduleOn'];

    trapEmergencies = json['trapEmergencies'];

    if (json['trapCounterSchedules'] != null) {
      trapCounterSchedules = [];
      json['trapCounterSchedules'].forEach((v) {
        trapCounterSchedules?.add(TrapSchedules.fromJson(v));
      });
    }
    if (json['trapFanSchedules'] != null) {
      trapFanSchedules = [];
      json['trapFanSchedules'].forEach((v) {
        trapFanSchedules?.add(TrapSchedules.fromJson(v));
      });
    }
    if (json['trapValveQutSchedules'] != null) {
      trapValveQutSchedules = [];
      json['trapValveQutSchedules'].forEach((v) {
        trapValveQutSchedules?.add(TrapSchedules.fromJson(v));
      });
    }
  }

  int? id;
  String? name;
  String? serialNumber;
  bool? isWorking;
  int? status;
  String? iema;
  String? valveQut;
  String? fan;
  bool? isCounterOn;
  bool? isCounterReadingFromSimCard;
  dynamic readingDate;
  double? lat;
  double? long;
  bool? isScheduleOn;
  List<dynamic>? trapEmergencies;
  List<TrapSchedules>? trapCounterSchedules;
  List<TrapSchedules>? trapFanSchedules;
  List<TrapSchedules>? trapValveQutSchedules;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['serialNumber'] = serialNumber;
    map['isWorking'] = isWorking;
    map['status'] = status;
    map['iema'] = iema;
    map['valveQut'] = valveQut;
    map['fan'] = fan;
    map['isCounterOn'] = isCounterOn;
    map['isCounterReadingFromSimCard'] = isCounterReadingFromSimCard;
    map['readingDate'] = readingDate;
    map['lat'] = lat;
    map['long'] = long;
    map['isScheduleOn'] = isScheduleOn;
    if (trapEmergencies != null) {
      map['trapEmergencies'] = trapEmergencies?.map((v) => v.toJson()).toList();
    }
    if (trapCounterSchedules != null) {
      map['trapCounterSchedules'] =
          trapCounterSchedules?.map((v) => v.toJson()).toList();
    }
    if (trapFanSchedules != null) {
      map['trapFanSchedules'] =
          trapFanSchedules?.map((v) => v.toJson()).toList();
    }
    if (trapValveQutSchedules != null) {
      map['trapValveQutSchedules'] =
          trapValveQutSchedules?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TrapSchedules {
  TrapSchedules({
    this.id,
    this.scdTime,
    this.status,
  });

  TrapSchedules.fromJson(dynamic json) {
    id = json['id'];
    scdTime = json['scdTime'];
    status = json['status'];
  }

  int? id;
  int? scdTime;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['scdTime'] = scdTime;
    map['status'] = status;
    return map;
  }
}

class TrapFanSchedules {
  TrapFanSchedules({
    this.id,
    this.scdTime,
    this.status,
  });

  TrapFanSchedules.fromJson(dynamic json) {
    id = json['id'];
    scdTime = json['scdTime'];
    status = json['status'];
  }

  int? id;
  int? scdTime;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['scdTime'] = scdTime;
    map['status'] = status;
    return map;
  }
}

class TrapCounterSchedules {
  TrapCounterSchedules({
    this.id,
    this.scdTime,
    this.status,
  });

  TrapCounterSchedules.fromJson(dynamic json) {
    id = json['id'];
    scdTime = json['scdTime'];
    status = json['status'];
  }

  int? id;
  int? scdTime;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['scdTime'] = scdTime;
    map['status'] = status;
    return map;
  }
}
