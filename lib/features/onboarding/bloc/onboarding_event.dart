part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class OnboardingChecked extends OnboardingEvent {
  const OnboardingChecked();
}

final class OnboardingCompleted extends OnboardingEvent {
  const OnboardingCompleted();
}
