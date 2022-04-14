import 'package:alfred_test_project/base/base_model.dart';
import 'package:alfred_test_project/base/base_response_model.dart';

class ResponseModel<D extends BaseModel> extends BaseResponseModel {
  final D? data;

  ResponseModel(String message, {int statusCode = 200, this.data})
      : super(message, statusCode: statusCode);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> responseData = super.toMap();
    if (data?.toMap() != null) {
      responseData['data'] = data?.toMap();
    }
    return responseData;
  }
}
