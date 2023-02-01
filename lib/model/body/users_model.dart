class UsersModel {
  UsersModel({
      this.id, 
      this.email, 
      this.name, 
      this.roleId, 
      this.roleName, 
      this.trapIds,});

  UsersModel.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    roleId = json['roleId'];
    roleName = json['roleName'];
    trapIds = json['trapIds'] != null ? json['trapIds'].cast<int>() : [];
  }
  String? id;
  String? email;
  String? name;
  String? roleId;
  String? roleName;
  List<int>? trapIds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['name'] = name;
    map['roleId'] = roleId;
    map['roleName'] = roleName;
    map['trapIds'] = trapIds;
    return map;
  }

}