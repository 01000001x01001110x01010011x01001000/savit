import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences,
        super(const OnboardingState.initial()) {
    on<OnboardingChecked>(_onOnboardingChecked);
    on<OnboardingCompleted>(_onOnboardingCompleted);
  }

  final SharedPreferences _sharedPreferences;

  Future<void> _onOnboardingChecked(
    OnboardingChecked event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(status: OnboardingStatus.loading));

    final bool done = _sharedPreferences.getBool(_onboardingDoneKey) ?? false;
    emit(
      state.copyWith(
        status: done ? OnboardingStatus.completed : OnboardingStatus.firstLaunch,
      ),
    );
  }

  Future<void> _onOnboardingCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) async {
    await _sharedPreferences.setBool(_onboardingDoneKey, true);
    emit(state.copyWith(status: OnboardingStatus.completed));
  }
}

const String _onboardingDoneKey = 'onboarding_done';
