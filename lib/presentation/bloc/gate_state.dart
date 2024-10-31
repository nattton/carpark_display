// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'gate_bloc.dart';

class GateState extends Equatable {
  final GateModel? gateIn;
  final GateModel? gateOut;
  final DelayedResult<String> loadingResult;

  const GateState({this.gateIn, this.gateOut, required this.loadingResult});

  @override
  List<Object?> get props => [gateIn, gateOut];

  GateState copyWith({
    GateModel? gateIn,
    GateModel? gateOut,
    DelayedResult<String>? loadingResult,
  }) {
    return GateState(
      gateIn: gateIn ?? this.gateIn,
      gateOut: gateOut ?? this.gateOut,
      loadingResult: loadingResult ?? this.loadingResult,
    );
  }
}
