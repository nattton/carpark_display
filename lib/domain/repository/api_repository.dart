import 'package:carpark_display/domain/model/last_gate_model.dart';

abstract class ApiRepository {
  Future<LastGateModel> getLastGate();
}
