// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class GateModel extends Equatable {
  final int id;
  final String gateName;
  final String plateNumber;
  final int memberId;

  const GateModel({
    required this.id,
    required this.gateName,
    required this.plateNumber,
    required this.memberId,
  });

  GateModel copyWith({
    int? id,
    String? gateName,
    String? plateNumber,
    int? memberId,
  }) {
    return GateModel(
      id: id ?? this.id,
      gateName: gateName ?? this.gateName,
      plateNumber: plateNumber ?? this.plateNumber,
      memberId: memberId ?? this.memberId,
    );
  }

  @override
  List<Object?> get props => [id, gateName, plateNumber, memberId];
}
