import 'package:alfred/alfred.dart';
import 'package:alfred_test_project/base/response_model.dart';

abstract class ApiController{
  late HttpRequest request;
  late HttpResponse response;

  Future<Map<String,dynamic>> requestBody() async => await request.bodyAsJsonMap;

  Future<ResponseModel> create();
  Future<ResponseModel> read({int? id});
  Future<ResponseModel> update(int id);
  Future<ResponseModel> delete(int id);

}

extension MapExt on Map{
  bool hasEmptyValue(String key) => !containsKey(key) || this[key] == null || (this[key] is String && (this[key] as String).isEmpty);
}