import 'package:flower_delivery_app/models/data_fields.dart';

class DataModels {
  final int? id;
  final String email;
  final String password;

  DataModels({this.id, required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        DataFields.id: id,
        DataFields.email: email,
        DataFields.password: password,
      };

  factory DataModels.fromJson(Map<String, dynamic> json) => DataModels(
        id: json[DataFields.id] as int?,
        email: json[DataFields.email] as String,
        password: json[DataFields.password] as String,
      );
}
