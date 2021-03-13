part of 'fetch_bloc.dart';

class FetchEvent {
  final String query;
  final String previewText;
  final int page;
  final int quantity;
  final FontSize size;

  FetchEvent(
    this.query, {
    required this.previewText,
    required this.page,
    required this.quantity,
    required this.size,
  });
}
