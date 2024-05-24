// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:users_model/providers/app_provider.dart';

StreamSubscription<List<ConnectivityResult>>? subscription;

late AppProvider appProvider;

Future checkConnectivity(BuildContext context) async {
  appProvider = Provider.of<AppProvider>(context, listen: false);

  subscription = Connectivity()
      .onConnectivityChanged
      .listen((List<ConnectivityResult> results) async {
    ConnectivityResult result = results[0]; // Extract the first result
    appProvider.setConnectivityChanges = appProvider.getConnectivityChanges + 1;
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      try {
        final response =
            await http.get(Uri.parse('https://www.google.com')).timeout(
          const Duration(seconds: 30),
          onTimeout: () {
            return http.Response('Error', 408);
          },
        );
        if (response.statusCode == 200) {
          if (kDebugMode) {
            print('Internet is accessible');
          }
          appProvider.setIsConnected = true;
          if (appProvider.getWasOffline) {
            // Only show success toast if user was offline before
            //! Display a snackbar to notify the user
            appProvider.showSnackBar(context, 'Back online');

            if (kDebugMode) {
              print('Back online');
            }
          }
          appProvider.setWasOffline = false; // Reset the flag
        } else {
          if (kDebugMode) {
            print(
                'Error: Failed to access internet (status code: ${response.statusCode})');
          }
          appProvider.setIsConnected = false; //was false
          appProvider.showSnackBar(context, 'No internet connection');

          if (kDebugMode) {
            print('No internet connection');
          }
          appProvider.setWasOffline = true; // Set the flag
        }
      } on TimeoutException catch (_) {
        appProvider.setIsConnected = false; //was false
        appProvider.setWasOffline = false; // Set the flag
      } on SocketException catch (e) {
        if (kDebugMode) {
          print('Error: Failed to check internet accessibility ($e)');
        }
        appProvider.setIsConnected = false; //was false
        appProvider.showSnackBar(context, 'No internet connection');

        if (kDebugMode) {
          print('No internet connection');
        }
        appProvider.setWasOffline = true; // Set the flag
      } catch (e) {
        // Handle other unforeseen errors
        if (kDebugMode) {
          print('Unforeseen error: $e');
        }
      }
    } else {
      appProvider.setIsConnected = false; //was false
      appProvider.showSnackBar(context, 'No internet connection');

      if (kDebugMode) {
        print('No internet connection');
      }
      appProvider.setWasOffline = true; // Set the flag
    }
    if (kDebugMode) {
      print('Connectivity: ${appProvider.getConnectivityChanges}');
    }
  });
}

