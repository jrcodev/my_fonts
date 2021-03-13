part of 'fetch_bloc.dart';

@immutable
abstract class FetchState {}

class FetchInitial extends FetchState {}

class FetchLoading extends FetchState {}

class FetchError extends FetchState {}

class FetchSuccess extends FetchState {
  final List<Font> fonts;
  final String highlight;
  final bool hasReachedMax;

  FetchSuccess({
    required this.fonts,
    required this.highlight,
    this.hasReachedMax = false,
  });

  bool get hasResults => fonts.isNotEmpty;

  FetchSuccess copyWith({
    List<Font>? fonts,
    String? highlight,
    bool? hasReachedMax,
  }) {
    return FetchSuccess(
      fonts: fonts ?? this.fonts,
      highlight: highlight ?? this.highlight,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
