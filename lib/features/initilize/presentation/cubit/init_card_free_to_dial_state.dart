part of 'init_card_free_to_dial_cubit.dart';

@immutable
sealed class InitCardFreeToDialState {}

final class InitCardFreeToDialInitial extends InitCardFreeToDialState {}

final class InitCardFreeToDialSuccessState extends InitCardFreeToDialState{
  final String message;
  InitCardFreeToDialSuccessState({required this.message});
}

final class InitCardFreeToDialFailureState extends InitCardFreeToDialState{
  final String message;
  InitCardFreeToDialFailureState({required this.message});
}

final class InitCardFreeToDialLoadingState extends InitCardFreeToDialState{}
