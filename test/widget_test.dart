import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:path_provider/path_provider.dart' as path;

void main() {
  test('', () async {
    // final dt = DafontDatasource();
    // final data = await dt.search('game', previewText: 'junior');
    // data.forEach((element) {
    //   print(element);
    // });
    final v = Platform.environment['HOMEPATH'];
    final path = "C:$v\\AppData\\Local\\Microsoft\\Windows\\Fonts";

    File("$path\\test.ttf").create(recursive: true);
  });
}
