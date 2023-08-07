import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salvapp_amcc/blocs/iklan/iklan_bloc.dart';
import 'package:salvapp_amcc/models/update_address_model.dart';
import 'package:salvapp_amcc/models/user_model.dart';
import 'package:salvapp_amcc/services/lokasi_services.dart';

part 'lokasi_event.dart';
part 'lokasi_state.dart';

class LokasiBloc extends Bloc<LokasiEvent, LokasiState> {
  LokasiBloc() : super(LokasiInitial()) {
    on<LokasiEvent>((event, emit) async {
      // TODO: implement event handler

      if (event is LokasiUpdate) {
        try {
          emit(LokasiLoading());
          final lokasi =
              await LokasiService().updateLokasi(event.updatedLocation!);
          emit(LokasiUpdateSuccess(lokasi));
        } catch (e) {
          emit(LokasiFailed(e.toString()));
        }
      }
    });
  }
}
