part of 'add_phone_numbers_cubit.dart';

@immutable
sealed class AddPhoneNumbersState {}

final class AddPhoneNumbersInitial extends AddPhoneNumbersState {}

final class AddPhoneNumbersSuccessState extends AddPhoneNumbersState {
  final String message;
  AddPhoneNumbersSuccessState({required this.message});
}

final class AddPhoneNumbersFailureState extends AddPhoneNumbersState {
  final String message;
  AddPhoneNumbersFailureState({required this.message});
}

final class AddPhoneNumbersLoadingState extends AddPhoneNumbersState {}
