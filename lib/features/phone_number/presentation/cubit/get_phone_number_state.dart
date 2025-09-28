part of 'get_phone_number_cubit.dart';

@immutable
sealed class GetPhoneNumberState {}

final class GetPhoneNumberInitial extends GetPhoneNumberState {}

final class GetPhoneNumbersSuccessState extends GetPhoneNumberState {
  final List<String> phoneNumbers;
  GetPhoneNumbersSuccessState({required this.phoneNumbers});
}

final class GetPhoneNumbersFailureState extends GetPhoneNumberState {
  final String message;
  GetPhoneNumbersFailureState({required this.message});
}

final class GetPhoneNumbersLoadingState extends GetPhoneNumberState {}
