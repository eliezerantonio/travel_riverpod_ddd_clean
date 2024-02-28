import 'package:hive/hive.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/domain/entities/trip.dart';

part 'trip_model.g.dart';

@HiveType(typeId: 0)
class TripModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<String> pictures;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final String location;

  TripModel({
    required this.title,
    required this.pictures,
    required this.description,
    required this.date,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'pictures': pictures,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'location': location,
    };
  }

  factory TripModel.fromEntity(Trip trip) => TripModel(
        title: trip.title,
        pictures: trip.pictures,
        description: trip.description,
        date: trip.date,
        location: trip.location,
      );

  Trip toEntity() => Trip(
        title: title,
        pictures: pictures,
        description: description,
        date: date,
        location: location,
      );
}
