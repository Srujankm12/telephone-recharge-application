part of 'change_card_mode_cubit.dart';

@immutable
sealed class ChangeCardModeState {}

final class ChangeCardModeInitial extends ChangeCardModeState {}

final class ChangeCardModeSuccessState extends ChangeCardModeState {
  final String message;
  ChangeCardModeSuccessState({required this.message});
}

final class ChangeCardModeFailureState extends ChangeCardModeState {
  final String message;
  ChangeCardModeFailureState({required this.message});
}

final class ChangeCardModeLoadingState extends ChangeCardModeState {}
