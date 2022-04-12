import 'package:alfred_test_project/base/base_model.dart';

class BaseResponseModel{
  final String message;
  final int statusCode;

  BaseResponseModel(this.message, {this.statusCode = 200});

  Map<String, dynamic> toMap() {
    Map<String,dynamic> responseData = {
      'message': message,
      'statusCode': statusCode
    };
    return responseData;
  }
}