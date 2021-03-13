import 'package:get_it/get_it.dart';
import 'package:my_fonts/app/data/font_datasource.dart';
import 'package:my_fonts/app/data/font_storage.dart';
import 'package:my_fonts/app/external/dafont_datasource.dart';
import 'package:my_fonts/app/external/font_repository.dart';
import 'package:my_fonts/app/external/linux_font_storage.dart';
import 'package:my_fonts/app/pages/home/blocs/fetch_bloc.dart';
import 'package:my_fonts/app/pages/home/cubits/search_cubit.dart';

void inject() {
  GetIt.I.registerSingleton<FontDatasource>(DafontDatasource());
  GetIt.I.registerSingleton<FontStorage>(LinuxFontStorage());
  GetIt.I.registerSingleton(
    FontRepository(
        datasource: GetIt.I.get<FontDatasource>(),
        storage: GetIt.I.get<FontStorage>()),
  );
  GetIt.I.registerSingleton(SearchCubit());
  GetIt.I.registerSingleton(FetchBloc(
    repository: GetIt.I.get<FontRepository>(),
  ));
}
