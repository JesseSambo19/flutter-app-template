import 'dart:async';

import 'package:flutter/material.dart';

//! The AppProvider class manages the state of the whole app.
class AppProvider with ChangeNotifier {
  //! constructors
  AppProvider();

  //! variables
  int _currentNavIndex = 0;
  bool _isConnected = true;
  bool _wasOffline = false; // Flag to track previous offline state
  int _connectivityChanges = 0; // Counter to track connectivity changes

  //! setters
  set setCurrentNavIndex(int value) {
    _currentNavIndex = value;
    notifyListeners();
  }

  set setIsConnected(bool value) {
    _isConnected = value;
    notifyListeners();
  }

  set setWasOffline(bool value) {
    _wasOffline = value;
    notifyListeners();
  }

  set setConnectivityChanges(int value) {
    _connectivityChanges = value;
    notifyListeners();
  }

  //! getters
  int get getCurrentNavIndex => _currentNavIndex;
  bool get getIsConnected => _isConnected;
  bool get getWasOffline => _wasOffline;
  int get getConnectivityChanges => _connectivityChanges;

  //! methods
  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

//!   Common Use Cases and Intervals:

//! Live Data (e.g., stock prices, sports scores): 5-10 seconds (consider user experience and battery usage)
//! Social Media Feeds: 15-30 seconds (balance updates with user experience)
//! News Updates: 30-60 minutes (depending on news category)
//! User Profile Information: Less frequent (manual refresh or on specific events)

  fetchDataPeriodically(
    BuildContext context,
    Future Function() fetchDataFunction,
  ) {
    Timer.periodic(const Duration(seconds: 30), (Timer timer) async {
      // Call the provided function to fetch data
      await fetchDataFunction();
    });
    // Notify listeners after updating data
    // notifyListeners();
    return fetchDataFunction();
  }
}