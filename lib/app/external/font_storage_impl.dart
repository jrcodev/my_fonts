import 'dart:io';

import 'package:archive/archive.dart';
import 'package:my_fonts/app/data/font_storage.dart';
import 'package:my_fonts/app/models/font.dart';

class FontPath {
  String path() {
    final isWindows = Platform.isWindows;
    final isLinux = Platform.isLinux;
    assert(isWindows || isLinux);

    if (isWindows) {
      final home = Platform.environment['HOMEPATH'];
      final path = "C:$home\\AppData\\Local\\Microsoft\\Windows\\Fonts\\";

      return path;
    } else {
      final path = "${Platform.environment['HOME']}/.fonts/";
      return path;
    }
  }
}

class FontStorageImpl implements FontStorage {
  final ZipDecoder decoder;

  const FontStorageImpl({required this.decoder});

  @override
  Future<void> save({required Font font}) async {
    final bytes = font.bytes;

    if (bytes != null) {
      final zip = decoder.decodeBytes(bytes);
      final path = FontPath().path();
      for (var fontData in zip) {
        if (fontData.isFile && fontData.name.endsWith('.ttf')) {
            final data = fontData.content;
            final file = await File('$path${fontData.name}').create(recursive: true);

            await file.writeAsBytes(data);
        }
      }
    }
  }
}
