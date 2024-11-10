class Member {
  final int id;
  final String name;
  final String type;

  Member({
    required this.id,
    required this.name,
    required this.type,
  });

  factory Member.fromJson(Map<String, dynamic> json) => switch (json) {
        {
          'id': int id,
          'name': String name,
          'type': String type,
        } =>
          Member(
            id: id,
            name: name,
            type: type,
          ),
        _ => throw const FormatException('Member: format error'),
      };
}
