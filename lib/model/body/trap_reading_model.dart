class TrapReadingModel {
  TrapReadingModel({
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
    // this.lastRead
  });

  TrapReadingModel.fromJson(dynamic json) {
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
    lastRead = LastReadingModel.fromJson(json['lastRead']);
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
  LastReadingModel? lastRead;
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

class LastReadingModel {
  LastReadingModel({
    this.id,
    this.readingDate,
    this.readingTime,
    this.lat,
    this.long,
    this.counter,
    this.fan,
    this.co2,
    this.co2Val,
    this.readingsmall,
    this.readingLarg,
    this.readingMosuqitoes,
    this.readingTempIn,
    this.readingTempOut,
    this.readingWindSpeed,
    this.readingHumidty,
    this.ambLight,
    this.battery,
    this.reception,
    this.powerDraw,
    this.trapId,
    this.readingFly,
  });

  LastReadingModel.fromJson(dynamic json) {
    id = json['id'];
    readingDate = json['readingDate'];
    readingTime = json['readingTime'];
    lat = json['lat'];
    long = json['long'];
    counter = json['counter'];
    fan = json['fan'];
    co2 = json['co2'];
    co2Val = json['co2Val'];
    readingsmall = json['readingsmall'];
    readingLarg = json['readingLarg'];
    readingMosuqitoes = json['readingMosuqitoes'];
    readingTempIn = json['readingTempIn'];
    readingTempOut = json['readingTempOut'];
    readingWindSpeed = json['readingWindSpeed'];
    readingHumidty = json['readingHumidty'];
    ambLight = json['ambLight'];
    battery = json['battery'];
    reception = json['reception'];
    powerDraw = json['powerDraw'];
    trapId = json['trapId'];
    readingFly = json['readingFly'];
  }

  int? id;
  String? readingDate;
  String? readingTime;
  int? lat;
  int? long;
  String? counter;
  String? fan;
  String? co2;
  String? co2Val;
  String? readingsmall;
  String? readingLarg;
  String? readingMosuqitoes;
  String? readingTempIn;
  String? readingTempOut;
  String? readingWindSpeed;
  String? readingHumidty;
  dynamic ambLight;
  dynamic battery;
  dynamic reception;
  dynamic powerDraw;
  int? trapId;
  String? readingFly;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['readingDate'] = readingDate;
    map['readingTime'] = readingTime;
    map['lat'] = lat;
    map['long'] = long;
    map['counter'] = counter;
    map['fan'] = fan;
    map['co2'] = co2;
    map['co2Val'] = co2Val;
    map['readingsmall'] = readingsmall;
    map['readingLarg'] = readingLarg;
    map['readingMosuqitoes'] = readingMosuqitoes;
    map['readingTempIn'] = readingTempIn;
    map['readingTempOut'] = readingTempOut;
    map['readingWindSpeed'] = readingWindSpeed;
    map['readingHumidty'] = readingHumidty;
    map['ambLight'] = ambLight;
    map['battery'] = battery;
    map['reception'] = reception;
    map['powerDraw'] = powerDraw;
    map['trapId'] = trapId;
    map['readingFly'] = readingFly;
    return map;
  }
}
