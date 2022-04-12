

import 'package:alfred_test_project/base/response_model.dart';
import 'package:alfred_test_project/models/user.dart';

import '../base/api_controller.dart';

class UserController extends ApiController{
  @override
  Future<ResponseModel> create() async{
    var body = await requestBody();
    if(body.hasEmptyValue("email")){
      throw ResponseModel("Please enter a valid email",statusCode: 422);
    }
    if(body.hasEmptyValue("phone")){
      throw ResponseModel("Please enter a valid phone number",statusCode: 422);
    }
    if(body.hasEmptyValue("password") || body['password'].length < 6){
      throw ResponseModel("Please enter a valid password of at least 6 characters",statusCode: 422);
    }
    User user = User(email: body['email'], phone: body['phone'], password: body['password']);
    user.save();
    return ResponseModel("Success",data: user);
  }

  @override
  Future<ResponseModel> delete(int id) async{
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> read({int? id}) async{
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> update(int id) async{
    // TODO: implement update
    throw UnimplementedError();
  }

}