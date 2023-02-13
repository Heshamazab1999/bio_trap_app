class FcmModel {
  String? title;
  String? message;

  FcmModel({this.title, this.message});

  FcmModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['body'];
  }
}
