import 'dart:async';

import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

class AddTrip {
  final TripRepository repository;

  AddTrip(this.repository);

  FutureOr<void> call(Trip trip) {
    repository.addTrip(trip);
  }
}
