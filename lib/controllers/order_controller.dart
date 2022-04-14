import 'package:alfred_test_project/base/response_list_model.dart';
import 'package:alfred_test_project/base/response_model.dart';

import '../base/api_controller.dart';
import '../base/base_response_model.dart';
import '../models/customer_order.dart';
import '../models/product.dart';

class OrderController extends ApiController {
  @override
  Future<BaseResponseModel> create() async {
    var body = await requestBody();
    if (body.hasEmptyValue("items")) {
      throw ResponseModel("Please select items to add to order",
          statusCode: 422);
    }
    if (body.hasEmptyValue("name")) {
      throw ResponseModel("Please enter a valid name", statusCode: 422);
    }
    if (body.hasEmptyValue("email")) {
      throw ResponseModel("Please enter a valid email", statusCode: 422);
    }
    if (body.hasEmptyValue("phoneNumber")) {
      throw ResponseModel("Please enter a valid phoneNumber", statusCode: 422);
    }
    if (body.hasEmptyValue("address")) {
      throw ResponseModel("Please enter a valid address", statusCode: 422);
    }
    if (body.hasEmptyValue("zip")) {
      throw ResponseModel("Please enter a valid zip", statusCode: 422);
    }
    if (body.hasEmptyValue("city")) {
      throw ResponseModel("Please enter a valid city", statusCode: 422);
    }
    if (body.hasEmptyValue("country")) {
      throw ResponseModel("Please enter a valid country", statusCode: 422);
    }

    try {
      CustomerOrder order = CustomerOrder(
          name: body['name'],
          email: body['email'],
          phoneNumber: body['phoneNumber'],
          address: body['address'],
          zip: body['zip'],
          city: body['city'],
          country: body['country']);
      var cartItems = body['items'] as List<dynamic>;
      for (var cartItem in cartItems) {
        order.items.add(Product.fromMap(cartItem));
      }
      order.customer.target = currentUser;
      order.save();
      return ResponseModel("Success", data: order);
    } catch (e) {
      throw ResponseModel("Unable to save Order. Reason: ${e.toString()}",
          statusCode: 500);
    }
  }

  @override
  Future<BaseResponseModel> read({int? id}) async {
    if (id == null) {
      return ResponseListModel("Success", data: CustomerOrder.listFromBox());
    }
    try {
      CustomerOrder? data = CustomerOrder.fromBox(id: id);
      return ResponseModel("Success", data: data);
    } catch (e) {
      throw ResponseModel("Order not found", statusCode: 404);
    }
  }

  Future<BaseResponseModel> readByUserId() async {
    try {
      return ResponseListModel("Success",
          data: CustomerOrder.listFromBox(uid: currentUser?.id));
    } catch (e) {
      throw ResponseModel("Orders not found", statusCode: 404);
    }
  }

  @override
  Future<BaseResponseModel> update(int id) async {
    throw ResponseModel("Order cannot be updated!", statusCode: 500);
  }

  @override
  Future<BaseResponseModel> delete(int id) async {
    CustomerOrder? order = CustomerOrder.fromBox(id: id);
    if (order == null) {
      throw ResponseModel("Order not found", statusCode: 404);
    }
    try {
      order.delete();
      return ResponseModel("Successfully deleted!", data: order);
    } catch (e) {
      throw ResponseModel(
          "Error while deleting Order!. Reason: ${e.toString()}",
          statusCode: 500);
    }
  }
}
