import 'package:alfred/alfred.dart';
import 'package:alfred_test_project/base/response_model.dart';

import '../base/api_controller.dart';
import '../controllers/user_controller.dart';

class ApisRouter {
  Map<String, ApiController> get routes => {
        "/user": UserController(),
      };

  static Future<Map<String,dynamic>> reqBuilder(HttpRequest req,HttpResponse res,ApiController controller,Function handler) async{
    controller
      ..request = req
      ..response = res;
    try{
      return (await handler()).toMap();
    }on ResponseModel catch(model){
      res.statusCode = model.statusCode;
      return model.toMap();
    }catch(e){
      res.statusCode = 500;
      return ResponseModel(e.toString(),statusCode: res.statusCode).toMap();
    }
  }

  static init(Alfred app) {
    var router = ApisRouter();

    router.routes.forEach((path, controller) {
      app.get(path, (req, res) async {

        return (await controller.read()).toMap();
      });
      app.get("$path/:id", (req, res) async => reqBuilder(req, res, controller, () async => (await controller.read(id: int.parse(req.params['id'])))));
      app.post(path, (req, res) async  => reqBuilder(req, res, controller, () async => (await controller.create())));
      app.put(path, (req, res) async => reqBuilder(req, res, controller, () async => (await controller.update(int.parse(req.params['id'])))));
      app.delete(path, (req, res) async => reqBuilder(req, res, controller, () async => (await controller.delete(int.parse(req.params['id'])))));
    });
  }
}
