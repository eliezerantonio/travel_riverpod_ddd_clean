import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../components/custom_searach_bar.dart';
import '../components/travel_card.dart';
import '../providers/trip_provider.dart';

class MyTripsScreen extends ConsumerWidget {
  const MyTripsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripListProvider = ref.watch(tripListNotifierProvider);

    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          CustomSearchBar(),
          tripListProvider.when(
            data: (list) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final trip = list[index];
                  return TravelCard(
                    imageUrl: trip.pictures[0],
                    title: trip.title,
                    description: trip.description,
                    date: DateFormat.yMMMEd().format(trip.date).toString(),
                    location: trip.location,
                    onDelete: () {
                      ref
                          .read(tripListNotifierProvider.notifier)
                          .removeTrip(index);
                      ref.read(tripListNotifierProvider.notifier).loadTrips();
                    },
                  );
                },
              );
            },
            error: (error, __) => Text("$error"),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        ],
      ),
    );
  }
}
