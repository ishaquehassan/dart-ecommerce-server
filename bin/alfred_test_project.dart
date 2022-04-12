import 'package:alfred/alfred.dart';

void main() async {
  final app = Alfred();
  app.get('/', (req, res) => 'Text response');
  await app.listen(9001);
}