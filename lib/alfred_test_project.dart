import 'package:alfred/alfred.dart';

import 'router/apis.dart';

void main() async {
  var app = Alfred();
  ApisRouter.init(app);
  await app.listen(9001);
}
