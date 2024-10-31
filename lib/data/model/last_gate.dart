import 'package:carpark_display/domain/model/last_gate_model.dart';

import 'gate_log.dart';

class LastGate {
  final GateLog gateIn;
  final GateLog gateOut;

  LastGate({required this.gateIn, required this.gateOut});

  factory LastGate.fromJson(Map<String, dynamic> json) => switch (json) {
        {
          'gateIn': Map<String, dynamic> gateIn,
          'gateOut': Map<String, dynamic> gateOut,
        } =>
          LastGate(
              gateIn: GateLog.fromJson(gateIn),
              gateOut: GateLog.fromJson(gateOut)),
        {
          'gate_in': Map<String, dynamic> gateIn,
          'gate_out': Map<String, dynamic> gateOut,
        } =>
          LastGate(
              gateIn: GateLog.fromJson(gateIn),
              gateOut: GateLog.fromJson(gateOut)),
        _ => throw const FormatException('LastGate: format error')
      };

  LastGateModel toLastGateModel() {
    return LastGateModel(
        gateIn: gateIn.toGateModel(), gateOut: gateOut.toGateModel());
  }
}
