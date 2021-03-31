import '../models/font.dart';
import '../models/font_size.dart';

abstract class FontDatasource {
  Future<List<Font>> search(
    String font, {
    String? previewText,
    int? page,
    int? quantity,
    FontSize? size,
  });

  Future<Font> download({required Font font});
}
