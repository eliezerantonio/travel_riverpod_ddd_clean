import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/data/repositories/trip_repository_impl.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/domain/repositories/trip_repository.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/domain/usecases/add_trip.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/domain/usecases/delete_trip.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/domain/usecases/get_trips.dart';

import '../../data/models/trip_model.dart';
import '../../domain/entities/trip.dart';

final triplocalDatasourceProvider = Provider<TripLocalDatasource>((ref) {
  final Box<TripModel> tripBox = Hive.box("trips");

  return TripLocalDatasource(tripBox: tripBox);
});

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final localDatasource = ref.read(triplocalDatasourceProvider);

  return TripRepositoryImpl(localDatasource);
});

final addTripProvider = Provider<AddTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);

  return AddTrip(repository);
});

final getTripsProvider = Provider<GetTrips>((ref) {
  final repository = ref.read(tripRepositoryProvider);

  return GetTrips(repository);
});

final deleteTripsProvider = Provider<DeleteTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);

  return DeleteTrip(repository);
});

final tripListNotifierProvider =
    StateNotifierProvider<TripListNotifier, AsyncValue<List<Trip>>>((ref) {
  final getTrips = ref.read(getTripsProvider);
  final addTrip = ref.read(addTripProvider);
  final deleteTrip = ref.read(deleteTripsProvider);
  return TripListNotifier(getTrips, addTrip, deleteTrip);
});

class TripListNotifier extends StateNotifier<AsyncValue<List<Trip>>> {
  final GetTrips _getTrips;
  final AddTrip _addTrip;
  final DeleteTrip _deleteTrip;

  TripListNotifier(this._getTrips, this._addTrip, this._deleteTrip)
      : super(const AsyncValue.loading()) {
    loadTrips();
  }

  Future<void> addNewTrip(Trip trip) async {
    await _addTrip(trip);
  }

  Future<void> removeTrip(int tripId) async {
    _deleteTrip(tripId);
  }

  Future<void> loadTrips() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final tripsOrFailure = await _getTrips();
    tripsOrFailure.fold((error) => state = const AsyncData([]),
        (trips) => state = AsyncData(trips));
  }
}
