import 'package:alfred_test_project/base/base_model.dart';

class ResponseModel<D extends BaseModel>{
  final String message;
  final int statusCode;
  final D? data;

  ResponseModel(this.message, {this.statusCode = 200, this.data});

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'statusCode': statusCode,
      'data': data?.toMap(),
    };
  }
}