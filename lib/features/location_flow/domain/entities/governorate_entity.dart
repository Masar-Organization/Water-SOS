class GovernorateEntity {
  final String id;
  final String name;

  const GovernorateEntity({required this.id, required this.name});

  @override
  bool operator ==(Object other) =>
      other is GovernorateEntity && other.id == id && other.name == name;

  @override
  int get hashCode => Object.hash(id, name);
}
