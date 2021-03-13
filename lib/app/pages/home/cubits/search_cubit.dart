import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_fonts/app/models/font_size.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchNone());

  void search(
    String query, {
    String previewText = "font",
    int page = 1,
    int quantity = 25,
    FontSize size = const MediumFont(),
  }) {
    emit(SearchData(query, previewText, page, quantity, size));
  }

  void fetch() {
    final currentState = state;

    if (currentState is SearchData) {
      emit(currentState.copyWith(page: currentState.page + 1));
    }
  }
}
