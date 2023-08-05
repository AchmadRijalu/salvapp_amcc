import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/beranda_buyer_model.dart';
import '../../models/beranda_seller_model.dart';
import '../../services/beranda_services.dart';

part 'beranda_event.dart';
part 'beranda_state.dart';

class BerandaBloc extends Bloc<BerandaEvent, BerandaState> {
  BerandaBloc() : super(BerandaInitial()) {
    on<BerandaEvent>((event, emit) async {
      // TODO: implement event handler

      if (event is BerandaGetAllBuyer) {
        try {
          emit(BerandaLoading());
          final berandaBuyer =
              await BerandaService().getBerandaAllData();
          emit(BerandaGetSuccess(berandaBuyer));
        } catch (e) {
          print(e.toString());
          emit(BerandaFailed(e.toString()));
        }
      }
    });
  }
}
