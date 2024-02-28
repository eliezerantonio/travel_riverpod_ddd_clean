import 'dart:async';

import '../entities/trip.dart';

abstract class TripRepository {
  FutureOr<List<Trip>> getTrip();
  FutureOr<void> addTrip(Trip trip);
  FutureOr<void> deleteTrip(int index);
}
