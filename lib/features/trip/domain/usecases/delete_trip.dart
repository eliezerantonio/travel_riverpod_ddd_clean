import 'dart:async';

import 'package:travel_riverpod_ddd_clean/features/trip/domain/repositories/trip_repository.dart';

class DeleteTrip {
  final TripRepository repository;

  DeleteTrip(this.repository);

  FutureOr<void> call(int index) {
    repository.deleteTrip(index);
  }
}
