import 'dart:async';
import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:alfred_test_project/base/base_response_model.dart';
import 'package:alfred_test_project/base/response_model.dart';
import 'package:alfred_test_project/controllers/categories_controller.dart';
import 'package:alfred_test_project/controllers/order_controller.dart';
import 'package:alfred_test_project/controllers/products_controller.dart';
import 'package:alfred_test_project/models/user.dart';

import '../base/api_controller.dart';
import '../controllers/user_controller.dart';

class ApisRouter {
  Map<String, ApiController> get routes => {
        "/user": UserController(),
      };

  Map<String, ApiController> get securedRoutes => {
        "/category": CategoriesController(),
        "/product": ProductsController(),
        "/order": OrderController(),
      };

  static Future<Map<String, dynamic>> reqBuilder(HttpRequest req,
      HttpResponse res, ApiController controller, Function handler) async {
    controller
      ..request = req
      ..response = res;
    try {
      return (await handler()).toMap();
    } on ResponseModel catch (model) {
      res.statusCode = model.statusCode;
      return model.toMap();
    } catch (e) {
      res.statusCode = 500;
      return ResponseModel(e.toString(), statusCode: res.statusCode).toMap();
    }
  }

  static FutureOr authMiddleware(
      HttpRequest req, HttpResponse res, ApiController controller) {
    if ((req.headers.value('authorization') ?? "").isEmpty) {
      res.statusCode = 403;
      res.json(BaseResponseModel("Header Authentication is required",
              statusCode: 403)
          .toMap());
      throw "Error";
    }
    User? authorizedUser;
    try {
      authorizedUser = User.fromBox(
          accessToken:
              (req.headers.value('authorization') ?? "").split(" ").last);
    } catch (e) {}
    if (authorizedUser == null) {
      res.statusCode = 403;
      res.json(BaseResponseModel(
              "Header Authentication is incorrect. Kindly signin again and update the access token",
              statusCode: 403)
          .toMap());
      throw "Error";
    } else {
      controller.currentUser = authorizedUser;
    }
  }

  static init(Alfred app) {
    var router = ApisRouter();
    _customRoutes(app);
    router.routes.forEach((path, controller) {
      _buildRoutes(app, path, controller);
    });
    router.securedRoutes.forEach((path, controller) {
      _buildRoutes(app, path, controller, isSecured: true);
    });
  }

  static _buildRoutes(Alfred app, String path, ApiController controller,
      {bool isSecured = false}) {
    app.get(
        path,
        (req, res) => reqBuilder(
            req, res, controller, () async => (await controller.read())),
        middleware: [
          if (isSecured) (req, res) => authMiddleware(req, res, controller)
        ]);
    app.get(
        "$path/:id",
        (req, res) async => reqBuilder(
            req,
            res,
            controller,
            () async =>
                (await controller.read(id: int.parse(req.params['id'])))),
        middleware: [
          if (isSecured) (req, res) => authMiddleware(req, res, controller)
        ]);
    app.post(
        path,
        (req, res) async => reqBuilder(
            req, res, controller, () async => (await controller.create())),
        middleware: [
          if (isSecured) (req, res) => authMiddleware(req, res, controller)
        ]);
    app.put(
        "$path/:id",
        (req, res) async => reqBuilder(req, res, controller,
            () async => (await controller.update(int.parse(req.params['id'])))),
        middleware: [
          if (isSecured) (req, res) => authMiddleware(req, res, controller)
        ]);
    app.delete(
        "$path/:id",
        (req, res) async => reqBuilder(req, res, controller,
            () async => throw ResponseModel("Ab nh krnai dnga delete 😎", statusCode: 403) //(await controller.delete(int.parse(req.params['id'])))
        ),
        middleware: [
          if (isSecured) (req, res) => authMiddleware(req, res, controller)
        ]);
  }

  static _customRoutes(Alfred app) {
    var uc = UserController();
    app.post(
        "user/signin",
        (req, res) async =>
            reqBuilder(req, res, uc, () async => (await uc.signIn())));
    app.get(
        "user/signout",
        (req, res) async =>
            reqBuilder(req, res, uc, () async => (await uc.logout())),
        middleware: [(req, res) => authMiddleware(req, res, uc)]);
    app.get(
        "assets/images/:dir/:file",
        (req, res) =>
            File("assets/${req.params['dir']}/${req.params['file']}"));

    var oc = OrderController();
    app.get(
        "user/orders",
        (req, res) async =>
            reqBuilder(req, res, oc, () async => (await oc.readByUserId())),
        middleware: [(req, res) => authMiddleware(req, res, oc)]);

    var pc = ProductsController();
    app.get(
        "product/search",
        (req, res) async => reqBuilder(req, res, oc,
            () async => (await pc.read(titleKeyword: req.uri.query))),
        middleware: [(req, res) => authMiddleware(req, res, oc)]);
  }
}
