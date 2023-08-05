import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/batal_iklan_buyer.dart';
import '../../models/iklan_add_model.dart';
import '../../models/iklan_buyer_detail_model.dart';
import '../../models/iklan_form_model.dart';
import '../../models/iklan_seller_detail_model.dart';
import '../../models/pembeli_iklan_model.dart';
import '../../models/penjual_iklan_model.dart';
import '../../services/iklan_services.dart';

part 'iklan_event.dart';
part 'iklan_state.dart';

class IklanBloc extends Bloc<IklanEvent, IklanState> {
  IklanBloc() : super(IklanInitial()) {
    on<IklanEvent>((event, emit) async {
      // TODO: implement event handler

      if (event is IklanGetAll) {
        try {
          emit(IklanLoading());

          final iklan = await IklanService().getIklanSeller();

          emit(IklanGetSuccess(iklan));
        } catch (e) {
          emit(IklanFailed(e.toString()));
        }
      }

      if (event is IklanRecommendationGetAll) {
        try {
          emit(IklanLoading());

          final rekomendasiIklan =
              await IklanService().getIklanRecommendation(event.categories!);

          emit(IklanRecommendationGetSuccess(rekomendasiIklan));
        } catch (e) {
          emit(IklanFailed(e.toString()));
        }
      }

      if (event is IklanAddAds) {
        try {
          emit(IklanLoading());
          final tambahIklan = await IklanService().addIklanBuyer(event.data!);

          emit(IklanAddSuccess(tambahIklan));
        } catch (e) {
          print(e.toString());
          emit(IklanFailed(e.toString()));
        }
      }

      if (event is IklanGetAllBuyer) {
        try {
          emit(IklanLoading());

          final iklan = await IklanService().getIklanBuyer(event.userdata!);

          emit(IklanBuyerGetSuccess(iklan));
        } catch (e) {
          emit(IklanFailed(e.toString()));
        }
      }

      if (event is IklanGetDetailBuyer) {
        try {
          emit(IklanLoading());

          final getIklan =
              await IklanService().getIklanBuyerDetail(event.adsId);

          emit(IklanBuyerGetDetailSuccess(getIklan));
        } catch (e) {
          emit(IklanFailed(e.toString()));
        }
      }

      if (event is IklanGetDetailSeller) {
        try {
          emit(IklanLoading());

          final getIklan =
              await IklanService().getIklanSellerDetail(event.adsId);
          emit(IklanSellerGetDetailSuccess(getIklan));
        } catch (e) {
          rethrow;
        }
      }

      if (event is IklanCancelBuyer) {
        try {
          emit(IklanLoading());

          final cancelIklan = await IklanService().batalIklanBuyer(event.adsId);
          emit(IklanCancelBuyerSuccess(cancelIklan));
        } catch (e) {
          emit(IklanFailed(e.toString()));
        }
      }
    });
  }
}
