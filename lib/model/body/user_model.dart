class UserModel {
  UserModel({
      this.data,});

  UserModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.token, 
      this.expiresOn, 
      this.role, 
      this.uId,});

  Data.fromJson(dynamic json) {
    token = json['token'];
    expiresOn = json['expiresOn'];
    role = json['role'];
    uId = json['uId'];
  }
  String? token;
  String? expiresOn;
  String? role;
  String? uId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['expiresOn'] = expiresOn;
    map['role'] = role;
    map['uId'] = uId;
    return map;
  }

}