part of 'lokasi_bloc.dart';

abstract class LokasiState extends Equatable {
  const LokasiState();

  @override
  List<Object> get props => [];
}

class LokasiInitial extends LokasiState {}

class LokasiUpdateSuccess extends LokasiState {
  final UpdateAddress? updatedLocation;

  const LokasiUpdateSuccess(this.updatedLocation);
  List<Object> get props => [updatedLocation!];
}

class LokasiLoading extends LokasiState {}

class LokasiFailed extends LokasiState {
  final String e;
  const LokasiFailed(this.e);

  @override
  List<Object> get props => super.props;
}
