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
