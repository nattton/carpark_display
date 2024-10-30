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
}
