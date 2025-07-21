// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

List<LocationModel> locationModelFromJson(String str) => List<LocationModel>.from(json.decode(str).map((x) => LocationModel.fromJson(x)));

String locationModelToJson(List<LocationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationModel {
    final int? locationId;
    final String? locationName;

    LocationModel({
        this.locationId,
        this.locationName,
    });

    LocationModel copyWith({
        int? locationId,
        String? locationName,
    }) => 
        LocationModel(
            locationId: locationId ?? this.locationId,
            locationName: locationName ?? this.locationName,
        );

    factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        locationId: json["LocationId"],
        locationName: json["LocationName"],
    );

    Map<String, dynamic> toJson() => {
        "LocationId": locationId,
        "LocationName": locationName,
    };
}

class Sector {
  final String name;
  final List<Town> towns;

  Sector({required this.name, required this.towns});
}

class Town {
  final int id;
  final String name;

  Town({required this.id, required this.name});
}
List<Sector> buildSectorsFromJson(List<LocationModel> data) {
  final Map<String, List<Town>> sectorMap = {};

  for (var item in data) {
    final locationName = item.locationName;
    final locationId = item.locationId;

    if (locationName!.contains('->')) {
      final parts = locationName.split('->');
      final sector = parts[0];
      final town = parts[1];

      sectorMap.putIfAbsent(sector, () => []);
      sectorMap[sector]!.add(Town(id: locationId!, name: town));
    }
  }

  return sectorMap.entries
      .map((entry) => Sector(name: entry.key, towns: entry.value))
      .toList();
}