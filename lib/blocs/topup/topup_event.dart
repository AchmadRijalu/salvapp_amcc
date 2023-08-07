part of 'topup_bloc.dart';

abstract class TopupEvent extends Equatable {
  const TopupEvent();

  @override
  List<Object> get props => [];
}

class TopupGetAmount extends TopupEvent {
  final TopupFormModel? topupFormModel;
  TopupGetAmount({required this.topupFormModel});

  @override
  List<Object> get props => [topupFormModel!];
}

class TopupMidtransSuccess extends TopupEvent {
  final String? midtransTransactionId;
  TopupMidtransSuccess({required this.midtransTransactionId});

  @override
  List<Object> get props => [midtransTransactionId!];
}
