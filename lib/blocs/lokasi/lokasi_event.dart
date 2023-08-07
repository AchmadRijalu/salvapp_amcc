part of 'lokasi_bloc.dart';

abstract class LokasiEvent extends Equatable {
  const LokasiEvent();

  @override
  List<Object> get props => [];
}

class LokasiUpdate extends LokasiEvent {
  late UpdatedAddress? updatedLocation;

  LokasiUpdate(this.updatedLocation);
  List<Object> get props => [updatedLocation!];
}
