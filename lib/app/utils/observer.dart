import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_fonts/app/pages/home/blocs/fetch_bloc.dart';
import 'package:my_fonts/app/pages/home/cubits/search_cubit.dart';

class Observer extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (bloc is SearchCubit) {
      final nextState = transition.nextState;
      if (nextState is SearchData) {
        GetIt.I.get<FetchBloc>().add(FetchEvent(
              nextState.query,
              previewText: nextState.previewText,
              page: nextState.page,
              quantity: nextState.quantity,
              size: nextState.size,
            ));
      }
    }
    super.onTransition(bloc, transition);
  }
}
