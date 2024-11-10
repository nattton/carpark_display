// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class GateModel extends Equatable {
  final int id;
  final String gateName;
  final String plateNumber;
  final int memberId;
  final String memberType;

  const GateModel({
    required this.id,
    required this.gateName,
    required this.plateNumber,
    required this.memberId,
    required this.memberType,
  });

  GateModel copyWith({
    int? id,
    String? gateName,
    String? plateNumber,
    int? memberId,
    String? memberType,
  }) {
    return GateModel(
      id: id ?? this.id,
      gateName: gateName ?? this.gateName,
      plateNumber: plateNumber ?? this.plateNumber,
      memberId: memberId ?? this.memberId,
      memberType: memberType ?? this.memberType,
    );
  }

  @override
  List<Object?> get props => [id, gateName, plateNumber, memberId, memberType];
}
