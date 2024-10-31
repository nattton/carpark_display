// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carpark_display/domain/model/gate_model.dart';
import 'package:equatable/equatable.dart';

class LastGateModel extends Equatable {
  final GateModel gateIn;
  final GateModel gateOut;

  const LastGateModel({required this.gateIn, required this.gateOut});

  LastGateModel copyWith({
    GateModel? gateIn,
    GateModel? gateOut,
  }) {
    return LastGateModel(
      gateIn: gateIn ?? this.gateIn,
      gateOut: gateOut ?? this.gateOut,
    );
  }

  @override
  List<Object?> get props => [gateIn, gateOut];
}
