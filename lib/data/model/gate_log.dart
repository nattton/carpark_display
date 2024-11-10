import 'package:carpark_display/data/model/member.dart';
import 'package:carpark_display/domain/model/gate_model.dart';

class GateLog {
  final int id;
  final String gateName;
  final String plateNumber;
  final int memberId;
  final Member? member;

  GateLog({
    required this.id,
    required this.gateName,
    required this.plateNumber,
    required this.memberId,
    required this.member,
  });

  factory GateLog.fromJson(Map<String, dynamic> json) => switch (json) {
        {
          'id': int id,
          'gateName': String gateName,
          'plateNumber': String plateNumber,
          'memberId': int memberId,
          'member': Map<String, dynamic> member,
        } =>
          GateLog(
              id: id,
              gateName: gateName,
              plateNumber: plateNumber,
              memberId: memberId,
              member: Member.fromJson(member)),
        {
          'id': int id,
          'gate_name': String gateName,
          'plate_number': String plateNumber,
          'member_id': int memberId,
          'member': Map<String, dynamic> member,
        } =>
          GateLog(
              id: id,
              gateName: gateName,
              plateNumber: plateNumber,
              memberId: memberId,
              member: Member.fromJson(member)),
        _ => throw const FormatException('GateLog: format error')
      };

  GateModel toGateModel() {
    return GateModel(
      id: id,
      gateName: gateName,
      plateNumber: plateNumber,
      memberId: memberId,
      memberType: memberId == 0 && member != null ? "visitor" : member!.type,
    );
  }
}
