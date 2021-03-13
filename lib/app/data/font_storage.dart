import '../models/font.dart';

abstract class FontStorage {
  Future<void> save({required Font font});
}
