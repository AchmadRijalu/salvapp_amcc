part of 'topup_bloc.dart';

abstract class TopupState extends Equatable {
  const TopupState();

  @override
  List<Object> get props => [];
}

class TopupInitial extends TopupState {}

class TopupLoading extends TopupState {}

class TopupSuccess extends TopupState {
  final MidtransPayment? midtransPayment;
  const TopupSuccess(this.midtransPayment);

  @override
  List<Object> get props => [midtransPayment!];
}

class TopupSuccessMidtrans extends TopupState {
  final MidtransSuccess? midtransSuccess;
  const TopupSuccessMidtrans(this.midtransSuccess);

  @override
  List<Object> get props => [midtransSuccess!];
}

class TopupFailed extends TopupState {
  final String e;
  const TopupFailed(this.e);

  @override
  List<Object> get props => [e];
}
