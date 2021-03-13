import 'package:dartz/dartz.dart';
import '../data/font_datasource.dart';
import '../data/font_storage.dart';
import '../models/font.dart';
import '../models/font_size.dart';

class FontRepository {
  final FontDatasource datasource;
  final FontStorage storage;

  FontRepository({required this.datasource, required this.storage});

  Future<Either<Exception, List<Font>>> search(
    String query, {
    String? previewText,
    int? page,
    int? quantity,
    FontSize? size,
  }) async {
    try {
      final result = await datasource.search(
        query,
        previewText: previewText,
        page: page,
        quantity: quantity,
        size: size,
      );

      return right(result);
    } on Exception {
      return left(Exception());
    }
  }

  Future<Either<Exception, void>> save({required Font font}) async {
    try {
      final result = await storage.save(font: font);
      return right(result);
    } on Exception {
      return left(Exception());
    }
  }
}
