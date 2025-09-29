part of 'check_card_mode_cubit.dart';

@immutable
sealed class CheckCardModeState {}

final class CheckCardModeInitial extends CheckCardModeState {}

final class CheckCardModeSuccessState extends CheckCardModeState {
  final String cardMode;
  CheckCardModeSuccessState({required this.cardMode});
}

final class CheckCardModeFailureState extends CheckCardModeState {
  final String message;
  CheckCardModeFailureState({required this.message});
}

final class CheckCardModeLoadingState extends CheckCardModeState {}
