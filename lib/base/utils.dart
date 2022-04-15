import 'dart:io';

Future<String?> getImageColor(String icon) async {
  return (await Process.run('php', ['color_extract.php', icon])).stdout;
}