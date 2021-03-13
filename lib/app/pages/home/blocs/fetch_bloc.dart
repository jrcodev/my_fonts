import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_fonts/app/external/font_repository.dart';
import 'package:my_fonts/app/models/font.dart';
import 'package:my_fonts/app/models/font_size.dart';
import 'package:rxdart/rxdart.dart';

part 'fetch_event.dart';
part 'fetch_state.dart';

class FetchBloc extends Bloc<FetchEvent, FetchState> {
  final FontRepository repository;
  FetchBloc({required this.repository}) : super(FetchInitial());

  @override
  Stream<FetchState> mapEventToState(
    FetchEvent event,
  ) async* {
    if (event.page <= 1) {
      yield FetchLoading();
      final result = await repository.search(
        event.query,
        previewText: event.previewText,
        page: event.page,
        quantity: event.quantity,
        size: event.size,
      );

      yield result.fold(
        (_) => FetchError(),
        (fonts) => FetchSuccess(
          fonts: fonts,
          highlight: event.query,
          hasReachedMax: fonts.length < event.quantity,
        ),
      );
    } else {
      final currentState = state;

      if (currentState is FetchSuccess) {
        final result = await repository.search(
          event.query,
          previewText: event.previewText,
          page: event.page,
          quantity: event.quantity,
          size: event.size,
        );

        yield result.fold((_) => FetchError(), (fonts) {
          if (fonts.isEmpty) {
            return currentState.copyWith(hasReachedMax: true);
          } else {
            return currentState.copyWith(fonts: currentState.fonts + fonts);
          }
        });
      }
    }
  }

  @override
  Stream<Transition<FetchEvent, FetchState>> transformEvents(
      Stream<FetchEvent> events, transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 300)),
      transitionFn,
    );
  }
}
