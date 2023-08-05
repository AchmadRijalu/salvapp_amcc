part of 'beranda_bloc.dart';

abstract class BerandaState extends Equatable {
  const BerandaState();

  @override
  List<Object> get props => [];
}

class BerandaInitial extends BerandaState {}

class BerandaLoading extends BerandaState {}



class BerandaGetSuccess extends BerandaState {
  final Beranda? beranda;
  const BerandaGetSuccess(this.beranda);
  List<Object> get props => [beranda!];
}

class BerandaFailed extends BerandaState {
  final String e;
  const BerandaFailed(this.e);

  @override
  //TODO: implement props
  List<Object> get props => super.props;
}
