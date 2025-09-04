part of 'init_card_restricted_cubit.dart';

@immutable
sealed class InitCardRestrictedState {}

final class InitCardRestrictedInitial extends InitCardRestrictedState {}

final class InitCardRestrictedSuccessState extends InitCardRestrictedState {
  final String message;
  InitCardRestrictedSuccessState({required this.message});
}

final class InitCardRestrictedFailureState extends InitCardRestrictedState {
  final String message;
  InitCardRestrictedFailureState({required this.message});
}

final class InitCardRestrictedLoadingState extends InitCardRestrictedState {}
