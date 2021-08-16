import '../../core/data/models/models.dart';
import '../../core/exports/app_dependencies.dart';
import '../../core/resources/extensions/extensions.dart';
import '../../domain/entities/entities.dart';

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
    return LocationModel(
      id: int.parse(map['id'].toString()),
      residentsIds: (map['residents'] as List)
          .stringifyMembers
          .map((character) => int.parse(character.allAfter('character/')))
          .toList(),
      name: map['name'].toString(),
      type: map['type'].toString(),
      dimension: map['dimension'].toString(),
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
  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'type': type,
        'dimension': dimension,
        'residents': residentsIds.map((residentId) => 'character/$residentId'),
      };
}
