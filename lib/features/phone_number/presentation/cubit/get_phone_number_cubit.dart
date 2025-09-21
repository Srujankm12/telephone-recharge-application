import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_phone_number_state.dart';

class GetPhoneNumberCubit extends Cubit<GetPhoneNumberState> {
  GetPhoneNumberCubit() : super(GetPhoneNumberInitial());
}
