import 'dart:convert';

PersonalDetailDeleteModel personalDetailDeleteModel(String str) =>
    PersonalDetailDeleteModel.fromJson(json.decode(str));

class PersonalDetailDeleteModel {
  String? status;
  int? statusCode;
  String? message;

  PersonalDetailDeleteModel({this.status, this.statusCode, this.message});

  PersonalDetailDeleteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}
