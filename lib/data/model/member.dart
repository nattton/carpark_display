class Member {
  final int id;
  final String name;

  Member({
    required this.id,
    required this.name,
  });

  factory Member.fromJson(Map<String, dynamic> json) => switch (json) {
        {
          'id': int id,
          'name': String name,
        } =>
          Member(
            id: id,
            name: name,
          ),
        _ => throw const FormatException('Member: format error'),
      };
}
