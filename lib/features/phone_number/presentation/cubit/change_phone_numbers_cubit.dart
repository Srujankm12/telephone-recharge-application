import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_phone_numbers_state.dart';

class ChangePhoneNumbersCubit extends Cubit<ChangePhoneNumbersState> {
  ChangePhoneNumbersCubit() : super(ChangePhoneNumbersInitial());
}
