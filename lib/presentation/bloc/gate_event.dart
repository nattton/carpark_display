part of 'gate_bloc.dart';

sealed class GateEvent extends Equatable {
  const GateEvent();
  @override
  List<Object?> get props => [];
}

final class Load extends GateEvent {
  const Load();
}

final class Subscribe extends GateEvent {
  const Subscribe();
}

final class Unsubscribe extends GateEvent {
  const Unsubscribe();
}

class GateInChanged extends GateEvent {
  final GateModel gateIn;
  const GateInChanged({required this.gateIn});

  @override
  List<Object> get props => [gateIn];
}

class GateOutChanged extends GateEvent {
  final GateModel gateOut;
  const GateOutChanged({required this.gateOut});

  @override
  List<Object> get props => [gateOut];
}

final class ClearError extends GateEvent {
  const ClearError();
}
