import 'package:my_fonts/app/data/font_storage.dart';
import 'package:my_fonts/app/models/font.dart';

class WindowsFontStorage implements FontStorage {
  @override
  Future<void> save({required Font font}) {
    throw UnimplementedError();
  }
}
