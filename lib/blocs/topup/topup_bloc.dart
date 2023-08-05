import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salvapp_amcc/services/topup_services.dart';

import '../../models/midtrans_model.dart';
import '../../models/topup_form_model.dart';

part 'topup_event.dart';
part 'topup_state.dart';

class TopupBloc extends Bloc<TopupEvent, TopupState> {
  TopupBloc() : super(TopupInitial()) {
    on<TopupEvent>((event, emit) async {
      // TODO: implement event handler

      if (event is TopupGetAmount) {
        try {
          emit(TopupLoading());
          // print(TopUpServices().topUp(event.topupFormModel!));
          final topupData = await TopUpServices().topUp(event.topupFormModel!);

          emit(TopupSuccess(topupData));
        } catch (e) {
          print(e.toString());
          emit(TopupFailed(e.toString()));
        }
      }
    });
  }
}
