import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/data/models/trip_model.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/domain/entities/trip.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/domain/repositories/trip_repository.dart';

import '../../../../core/failures.dart';

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
  Future<Either<Failure, List<Trip>>> getTrips() async {
    try {
      final tripModels = tripLocalDatasource.getTrips();
      List<Trip> res = tripModels.map((model) => model.toEntity()).toList();
      return Right(res);
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }
}
