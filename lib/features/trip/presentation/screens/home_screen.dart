import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/presentation/screens/add_trip_screen.dart';
import 'package:travel_riverpod_ddd_clean/features/trip/presentation/screens/my_trip_screen.dart';

class HomeScreen extends ConsumerWidget {
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  final _pageController = PageController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _pageController.addListener(() {
      _currentPage.value = _pageController.page!.round();
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi Eliezer !! ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Text("Traveling Today ?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          const MyTripsScreen(),
          AddTripScreen(),
          const Text("3"),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (_, pageIndex, child) {
            return BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    label: "My Trips", icon: Icon(Icons.list)),
                BottomNavigationBarItem(
                    label: "Add Trip", icon: Icon(Icons.add)),
                BottomNavigationBarItem(label: "Map", icon: Icon(Icons.map)),
              ],
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
              currentIndex: pageIndex,
            );
          }),
    );
  }
}
