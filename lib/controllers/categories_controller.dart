import 'package:alfred_test_project/base/response_list_model.dart';
import 'package:alfred_test_project/base/response_model.dart';

import '../base/api_controller.dart';
import '../base/base_response_model.dart';
import '../models/category.dart';

class CategoriesController extends ApiController {
  @override
  Future<BaseResponseModel> create() async {
    var body = await requestBody();
    if (body.hasEmptyValue("title")) {
      throw ResponseModel("Please enter a valid title", statusCode: 422);
    }
    if (body.hasEmptyValue("icon")) {
      throw ResponseModel("Please enter a valid icon", statusCode: 422);
    }
    Category? existingEmailCheck;
    try {
      existingEmailCheck = Category.fromBox(title: body['title']);
    } catch (e) {
    } finally {
      if (existingEmailCheck != null) {
        throw ResponseModel("Category already exists with same title",
            statusCode: 409);
      }
    }

    try {
      Category cat = Category(title: body['title'], icon: body['icon']);
      cat.save();
      return ResponseModel("Success", data: cat);
    } catch (e) {
      throw ResponseModel("Unable to save Category. Reason: ${e.toString()}",
          statusCode: 500);
    }
  }

  @override
  Future<BaseResponseModel> read({int? id}) async {
    if (id == null) {
      return ResponseListModel("Success", data: Category.listFromBox());
    }
    try {
      Category? cat = Category.fromBox(id: id);
      return ResponseModel("Success", data: cat);
    } catch (e) {
      throw ResponseModel("Category not found", statusCode: 404);
    }
  }

  @override
  Future<BaseResponseModel> update(int id) async {
    var body = await requestBody();
    Category? cat = Category.fromBox(id: id);
    if (cat == null) {
      throw ResponseModel("User not found", statusCode: 404);
    }
    if (!body.hasEmptyValue("title")) {
      cat.title = body['title'];
    }
    if (!body.hasEmptyValue("icon")) {
      cat.icon = body['icon'];
    }
    try {
      cat.save();
      return ResponseModel("Success", data: cat);
    } catch (e) {
      throw ResponseModel("Unable to save category. Reason: ${e.toString()}",
          statusCode: 500);
    }
  }

  @override
  Future<BaseResponseModel> delete(int id) async {
    Category? cat = Category.fromBox(id: id);
    if (cat == null) {
      throw ResponseModel("Category not found", statusCode: 404);
    }
    try {
      cat.delete();
      return ResponseModel("Successfully deleted!", data: cat);
    } catch (e) {
      throw ResponseModel(
          "Error while deleting Category!. Reason: ${e.toString()}",
          statusCode: 500);
    }
  }
}
