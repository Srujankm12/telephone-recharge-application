part of 'get_card_mode_cubit.dart';

@immutable
sealed class GetCardModeState {}

final class GetCardModeInitial extends GetCardModeState {}

final class GetCardModeSuccessState extends GetCardModeState {
  final String cardMode;
  GetCardModeSuccessState({required this.cardMode});
}

final class GetCardModeFailureState extends GetCardModeState {
  final String message;
  GetCardModeFailureState({required this.message});
}

final class GetCardModeLoadingState extends GetCardModeState {}
