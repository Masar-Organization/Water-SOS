class RegionEntity {
  final String id;
  final String name;
  final String governorateId;

  const RegionEntity({
    required this.id,
    required this.name,
    required this.governorateId,
  });

  @override
  bool operator ==(Object other) =>
      other is RegionEntity &&
      other.id == id &&
      other.name == name &&
      other.governorateId == governorateId;

  @override
  int get hashCode => Object.hash(id, name, governorateId);
}
