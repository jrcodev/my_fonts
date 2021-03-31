import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('', () async {
    // final dt = DafontDatasource();
    // final data = await dt.search('game', previewText: 'junior');
    // data.forEach((element) {
    //   print(element);
    // });
    final v = Platform.environment['HOMEPATH'];
    final path = "C:$v\\AppData\\Local\\Microsoft\\Windows\\Fonts";
    print(path);
    //File("$path\\test.ttf").create(recursive: true);
  });
}
