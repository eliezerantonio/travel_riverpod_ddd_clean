import 'dart:async';

import 'package:travel_riverpod_ddd_clean/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/data/models/trip_model.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/domain/entities/trip.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDatasource tripLocalDatasource;

  TripRepositoryImpl(this.tripLocalDatasource);

  @override
  FutureOr<void> addTrip(Trip trip) {
    final tripModel = TripModel.fromEntity(trip);
    tripLocalDatasource.addTrips(tripModel);
  }

  @override
  FutureOr<void> deleteTrip(int index) {
    tripLocalDatasource.deleteTrip(index);
  }

  @override
  FutureOr<List<Trip>> getTrip() {
    final tripModels = tripLocalDatasource.getTrips();

    final response = tripModels.map((model) => model.toEntity()).toList();
    return response;
  }
}
