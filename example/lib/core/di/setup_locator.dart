import 'package:get_it/get_it.dart';
import '../../presentation/cubits/app/app_cubit.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AppCubit>(() => AppCubit());
}
