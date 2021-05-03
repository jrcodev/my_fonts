import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fonts/app/di/injection.dart';
import 'package:my_fonts/app/utils/observer.dart';

import 'app/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  inject();
  Bloc.observer = Observer();
  runApp(AppWidget());
}
