class StreetEntity {
  final String id;
  final String name;
  final String regionId;

  const StreetEntity({
    required this.id,
    required this.name,
    required this.regionId,
  });

  @override
  bool operator ==(Object other) =>
      other is StreetEntity &&
      other.id == id &&
      other.name == name &&
      other.regionId == regionId;

  @override
  int get hashCode => Object.hash(id, name, regionId);
}
