import 'package:alfred_test_project/base/response_list_model.dart';
import 'package:alfred_test_project/base/response_model.dart';
import 'package:alfred_test_project/models/user.dart';

import '../base/api_controller.dart';
import '../base/base_response_model.dart';
import '../base/guid_gen.dart';

class UserController extends ApiController {
  @override
  Future<BaseResponseModel> create() async {
    var body = await requestBody();
    if (body.hasEmptyValue("email")) {
      throw ResponseModel("Please enter a valid email", statusCode: 422);
    }
    if (body.hasEmptyValue("phone")) {
      throw ResponseModel("Please enter a valid phone number", statusCode: 422);
    }
    if (body.hasEmptyValue("password") || body['password'].length < 6) {
      throw ResponseModel(
          "Please enter a valid password of at least 6 characters",
          statusCode: 422);
    }
    User? existingEmailCheck;
    try {
      existingEmailCheck = User.fromBox(email: body['email']);
    } catch (e) {
    } finally {
      if (existingEmailCheck != null) {
        throw ResponseModel("User already exists with same email",
            statusCode: 409);
      }
    }

    try {
      User user = User(
          email: body['email'],
          phone: body['phone'],
          password: body['password']);
      user.save();
      return ResponseModel("Success", data: user);
    } catch (e) {
      throw ResponseModel("Unable to save user. Reason: ${e.toString()}",
          statusCode: 500);
    }
  }

  @override
  Future<BaseResponseModel> read({int? id}) async {
    if (id == null) {
      return ResponseListModel("Success", data: User.listFromBox());
    }
    try {
      User? user = User.fromBox(id: id);
      return ResponseModel("Success", data: user);
    } catch (e) {
      throw ResponseModel("User not found", statusCode: 404);
    }
  }

  @override
  Future<BaseResponseModel> update(int id) async {
    var body = await requestBody();
    User? user = User.fromBox(id: id);
    if (user == null) {
      throw ResponseModel("User not found", statusCode: 404);
    }
    if (!body.hasEmptyValue("email")) {
      user.email = body['email'];
    }
    if (!body.hasEmptyValue("phone")) {
      user.phone = body['phone'];
    }
    if (!body.hasEmptyValue("password")) {
      user.password = body['password'];
    }
    try {
      user.save();
      return ResponseModel("Success", data: user);
    } catch (e) {
      throw ResponseModel("Unable to save user. Reason: ${e.toString()}",
          statusCode: 500);
    }
  }

  @override
  Future<BaseResponseModel> delete(int id) async {
    User? user = User.fromBox(id: id);
    if (user == null) {
      throw ResponseModel("User not found", statusCode: 404);
    }
    try {
      user.delete();
      return ResponseModel("Successfully deleted!", data: user);
    } catch (e) {
      throw ResponseModel("Error while deleting user!. Reason: ${e.toString()}",
          statusCode: 500);
    }
  }

  Future<BaseResponseModel> signIn() async {
    var body = await requestBody();
    if (body.hasEmptyValue("email")) {
      throw ResponseModel("Please enter a valid email", statusCode: 422);
    }
    if (body.hasEmptyValue("password") || body['password'].length < 6) {
      throw ResponseModel(
          "Please enter a valid password of at least 6 characters",
          statusCode: 422);
    }

    try {
      User? user =
          User.fromBox(email: body['email'], password: body['password']);
      user?.accessToken = GUIDGen.generate();
      user?.save();
      return ResponseModel("Success", data: user);
    } catch (e) {
      throw ResponseModel("User not found", statusCode: 404);
    }
  }

  Future<BaseResponseModel> logout() async {
    try {
      currentUser?.accessToken = null;
      currentUser?.save();
      return ResponseModel("Success", data: currentUser);
    } catch (e) {
      throw ResponseModel("User not found", statusCode: 404);
    }
  }
}
