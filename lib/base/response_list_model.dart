import 'package:alfred_test_project/base/base_model.dart';

import 'base_response_model.dart';

class ResponseListModel<D extends List<BaseModel>> extends BaseResponseModel {
  final D? data;

  ResponseListModel(String message, {int statusCode = 200, this.data})
      : super(message, statusCode: statusCode);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> responseData = super.toMap();
    if (data != null) {
      responseData['data'] = [];
      data?.forEach((element) {
        responseData['data'].add(element.toMap());
      });
    }
    return responseData;
  }
}
