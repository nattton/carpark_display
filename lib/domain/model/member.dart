class Member {
  final int id;
  final String name;
  final String telephone;
  final String address;
  final String type;
  final String status;

  Member({
    required this.id,
    required this.name,
    required this.telephone,
    required this.address,
    required this.type,
    required this.status,
  });

  factory Member.fromJson(Map<String, dynamic> json) => switch (json) {
        {
          'id': int id,
          'name': String name,
          'telephone': String telephone,
          'address': String address,
          'type': String type,
          'status': String status,
        } =>
          Member(
              id: id,
              name: name,
              telephone: telephone,
              address: address,
              type: type,
              status: status),
        _ => throw const FormatException('Member: format error'),
      };
}
