part of 'init_card_cubit.dart';

@immutable
sealed class InitCardState {}

final class InitCardInitial extends InitCardState {}

final class InitCardSuccessState extends InitCardState {
  final String message;
  InitCardSuccessState({required this.message});
}

final class InitCardFailureState extends InitCardState {
  final String message;
  InitCardFailureState({required this.message});
}

final class IntiCardLoadingState extends InitCardState {}
