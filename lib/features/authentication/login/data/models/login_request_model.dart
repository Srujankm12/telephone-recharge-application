import 'dart:convert';

import 'package:telephone_recharge_application/features/authentication/login/domain/entities/login_request_entity.dart';

class LoginRequestModel extends LoginRequestEntity {
  const LoginRequestModel({
    required super.email, 
    required super.password
  });
  
  String toJson(){
    return jsonEncode({
      "email": email,
      "password": password,
    });
  }
}