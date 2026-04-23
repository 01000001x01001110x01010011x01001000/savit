part of 'onboarding_bloc.dart';

enum OnboardingStatus { initial, loading, firstLaunch, completed }

final class OnboardingState extends Equatable {
  final OnboardingStatus status;

  const OnboardingState({required this.status});

  const OnboardingState.initial() : status = OnboardingStatus.initial;

  OnboardingState copyWith({OnboardingStatus? status}) {
    return OnboardingState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => <Object?>[status];
}
