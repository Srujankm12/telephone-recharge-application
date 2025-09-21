import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_phone_numbers_state.dart';

class AddPhoneNumbersCubit extends Cubit<AddPhoneNumbersState> {
  AddPhoneNumbersCubit() : super(AddPhoneNumbersInitial());
}
