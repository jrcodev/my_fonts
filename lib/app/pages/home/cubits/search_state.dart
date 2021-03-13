part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchNone extends SearchState {}

class SearchData extends SearchState {
  final String query;
  final String previewText;
  final int page;
  final int quantity;
  final FontSize size;

  SearchData(
    this.query,
    this.previewText,
    this.page,
    this.quantity,
    this.size,
  );

  SearchData copyWith({
    String? query,
    String? previewText,
    int? page,
    int? quantity,
    FontSize? size,
  }) {
    return SearchData(
      query ?? this.query,
      previewText ?? this.previewText,
      page ?? this.page,
      quantity ?? this.quantity,
      size ?? this.size,
    );
  }
}
