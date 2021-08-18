import "../../core/data/models/models.dart";
import "../../core/exports/app_dependencies.dart";
import "../../core/resources/extensions/extensions.dart";
import "../../domain/entities/entities.dart";

class LocationModel extends Model {
  LocationModel({
    required this.id,
    required this.residentsIds,
    required this.name,
    required this.type,
    required this.dimension,
  });

  final int id;
  final List<int> residentsIds;
  final String name;
  final String type;
  final String dimension;

  @override
  List<Object?> get props => [id];

  static LocationModel fromMap(Map<String, dynamic> map) {
    dynamic results = map;
    if (map.containsKey("results")) results = map["results"];
    return LocationModel(
      id: int.tryParse(results["id"].toString()) ?? -1,
      residentsIds: (results["residents"] as List)
          .stringifyMembers
          .map((character) => int.tryParse(character.allAfter("character/")) ?? -1)
          .toList(),
      name: results["name"].toString(),
      type: results["type"].toString(),
      dimension: results["dimension"].toString(),
    );
  }

  @override
  LocationEntity get toEntity => LocationEntity(
        id: id,
        residentsIds: residentsIds,
        name: name,
        type: type,
        dimension: dimension,
      );

  @override
  Map<String, dynamic> get toJson => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "residents": residentsIds.map((residentId) => "character/$residentId"),
      };
}

extension LocationModelToEntityList on List<LocationModel> {
  List<LocationEntity> get toEntityList {
    final entities = <LocationEntity>[];
    forEach((model) => entities.add(model.toEntity));
    return entities;
  }
}
