import 'package:archive/archive.dart';
import 'package:my_fonts/app/data/font_storage.dart';
import 'package:my_fonts/app/models/font.dart';
import 'package:http/http.dart' show get;
import 'dart:io' show File, Platform;

class LinuxFontStorage implements FontStorage {
  final ZipDecoder decoder;

  LinuxFontStorage(this.decoder);

  @override
  Future<void> save({required Font font}) async {
    final result = await get(Uri.parse(font.link));
    final zip = decoder.decodeBytes(result.bodyBytes);
    var path = "${Platform.environment['HOME']}/.fonts/myfonts";

    for (var font in zip) {
      if (font.isFile ||
          font.name.endsWith('.ttf') ||
          font.name.endsWith('.otf')) {
        final data = font.content;
        final file = await File("$path/${font.name}").create(recursive: true);
        await file.writeAsBytes(data);
      }
    }
  }
}
