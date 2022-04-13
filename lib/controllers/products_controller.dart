import 'package:alfred_test_project/base/response_list_model.dart';
import 'package:alfred_test_project/base/response_model.dart';

import '../base/api_controller.dart';
import '../base/base_response_model.dart';
import '../models/category.dart';
import '../models/product.dart';

class ProductsController extends ApiController {
  @override
  Future<BaseResponseModel> create() async {
    var body = await requestBody();
    if (body.hasEmptyValue("catId")) {
      throw ResponseModel("Please enter a category id", statusCode: 422);
    }
    if(!Category.exists(body['catId'])){
      throw ResponseModel("Please enter a category id that exists", statusCode: 404);
    }
    if (body.hasEmptyValue("title")) {
      throw ResponseModel("Please enter a valid title", statusCode: 422);
    }
    if (body.hasEmptyValue("unit")) {
      throw ResponseModel("Please enter a valid unit", statusCode: 422);
    }
    if (body.hasEmptyValue("stockAvailable")) {
      throw ResponseModel("Please enter a valid stock available qty",
          statusCode: 422);
    }
    if (body.hasEmptyValue("image")) {
      throw ResponseModel("Please enter a valid image URL", statusCode: 422);
    }
    if (body.hasEmptyValue("price")) {
      throw ResponseModel("Please enter a valid price", statusCode: 422);
    }
    Product? existingTitleCheck;
    try {
      existingTitleCheck = Product.fromBox(title: body['title']);
    }catch(e){} finally {
      if (existingTitleCheck != null) {
        throw ResponseModel("Product already exists with same title",
            statusCode: 409);
      }
    }

    try {
      Product prod = Product(catId: int.parse(body['catId']),
          title: body['title'], image: body['image'], unit: body['unit'], price: double.parse(body['price']),stockAvailable: int.parse(body['stockAvailable']));
      prod.save();
      return ResponseModel("Success", data: prod);
    } catch (e) {
      throw ResponseModel("Unable to save Product. Reason: ${e.toString()}",
          statusCode: 500);
    }
  }

  @override
  Future<BaseResponseModel> read({int? id}) async {
    if (id == null) {
      return ResponseListModel("Success", data: Product.listFromBox());
    }
    try {
      return ResponseListModel("Success", data: Product.listFromBox(catId: id));
    } catch (e) {
      throw ResponseModel("Product not found", statusCode: 404);
    }
  }

  @override
  Future<BaseResponseModel> update(int id) async {
    var body = await requestBody();
    Product? prod = Product.fromBox(id: id);
    if (prod == null) {
      throw ResponseModel("User not found", statusCode: 404);
    }
    if (!body.hasEmptyValue("catId") && Category.exists(body['catId'])) {
      prod.catId = int.parse(body['catId']);
    }
    if (!body.hasEmptyValue("title")) {
      prod.title = body['title'];
    }
    if (!body.hasEmptyValue("image")) {
      prod.image = body['image'];
    }
    if (!body.hasEmptyValue("unit")) {
      prod.unit = body['unit'];
    }
    if (!body.hasEmptyValue("price")) {
      prod.price = double.parse(body['price']);
    }
    if (!body.hasEmptyValue("stockAvailable")) {
      prod.stockAvailable = int.parse(body['stockAvailable']);
    }
    try {
      prod.save();
      return ResponseModel("Success", data: prod);
    } catch (e) {
      throw ResponseModel("Unable to save Product. Reason: ${e.toString()}",
          statusCode: 500);
    }
  }

  @override
  Future<BaseResponseModel> delete(int id) async {
    Product? cat = Product.fromBox(id: id);
    if (cat == null) {
      throw ResponseModel("Product not found", statusCode: 404);
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
