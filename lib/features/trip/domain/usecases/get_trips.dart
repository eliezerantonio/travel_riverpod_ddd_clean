import 'dart:async';

import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

class GetTrips {
  final TripRepository repository;

  GetTrips(this.repository);

  FutureOr<List<Trip>> call() {
    return repository.getTrip();
  }
}
