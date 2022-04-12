import 'package:alfred/alfred.dart';
import 'package:alfred_test_project/base/base_response_model.dart';
import 'package:alfred_test_project/models/user.dart';

abstract class ApiController{
  late HttpRequest request;
  late HttpResponse response;
  User? currentUser;

  Future<Map<String,dynamic>> requestBody() async => await request.bodyAsJsonMap;

  Future<BaseResponseModel> create();
  Future<BaseResponseModel> read({int? id});
  Future<BaseResponseModel> update(int id);
  Future<BaseResponseModel> delete(int id);

}

extension MapExt on Map{
  bool hasEmptyValue(String key) => !containsKey(key) || this[key] == null || (this[key] is String && (this[key] as String).isEmpty);
}