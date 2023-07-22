part of 'topup_bloc.dart';

abstract class TopupState extends Equatable {
  const TopupState();
  
  @override
  List<Object> get props => [];
}

class TopupInitial extends TopupState {}
