import 'package:get_it/get_it.dart';
import 'package:savit/features/language/bloc/language_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:savit/features/home/bloc/home_bloc.dart';
import 'package:savit/features/onboarding/bloc/onboarding_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  if (!locator.isRegistered<SharedPreferences>()) {
    locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  }

  if (!locator.isRegistered<OnboardingBloc>()) {
    locator.registerLazySingleton<OnboardingBloc>(
      () => OnboardingBloc(sharedPreferences: locator<SharedPreferences>()),
    );
  }

  if (!locator.isRegistered<HomeBloc>()) {
    locator.registerLazySingleton<HomeBloc>(HomeBloc.new);
  }

  if (!locator.isRegistered<LanguageCubit>()) {
    locator.registerLazySingleton<LanguageCubit>(
      () => LanguageCubit(sharedPreferences: locator<SharedPreferences>()),
    );
  }
}
