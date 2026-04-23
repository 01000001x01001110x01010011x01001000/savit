part of 'home_bloc.dart';

enum HomeStatus { initial, ready }

final class HomeState extends Equatable {
  final HomeStatus status;

  const HomeState({required this.status});

  const HomeState.initial() : status = HomeStatus.initial;
  const HomeState.ready() : status = HomeStatus.ready;

  @override
  List<Object?> get props => <Object?>[status];
}
