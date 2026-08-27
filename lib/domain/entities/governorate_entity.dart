/// Pure domain entity — no JSON, no Flutter, no dependency on how the
/// data layer fetched it (API, local dummy list, cache, ...).
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
