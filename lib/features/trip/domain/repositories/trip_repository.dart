import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/failures.dart';
import '../entities/trip.dart';

abstract class TripRepository {
  Future<Either<Failure, List<Trip>>> getTrips();
  FutureOr<void> addTrip(Trip trip);
  FutureOr<void> deleteTrip(int index);
}
