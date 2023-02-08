class ReadingTrapModel {
  ReadingTrapModel({
      this.readings, 
      this.count,});

  ReadingTrapModel.fromJson(dynamic json) {
    if (json['readings'] != null) {
      readings = [];
      json['readings'].forEach((v) {
        readings?.add(Readings.fromJson(v));
      });
    }
    count = json['count'];
  }
  List<Readings>? readings;
  String? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (readings != null) {
      map['readings'] = readings?.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    return map;
  }

}

class Readings {
  Readings({
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
      this.readingFly,});

  Readings.fromJson(dynamic json) {
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
  double? lat;
  double? long;
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