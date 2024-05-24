// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:users_model/hive/hive_boxes/shopping_box.dart';

import '../models/hive_model.dart';

class HiveProvider with ChangeNotifier {
  final ShoppingBox shoppingBox;

  //! List to hold the items from the Hive box
  List<HiveModel> _items = [];
  late dynamic _data;

  HiveProvider({required this.shoppingBox});

  set setData(var value) {
    _data = value;
    notifyListeners();
  }

  get getData => _data;

  get getItems => _items;

  //! Function to refresh the list of items
  void refreshItems(BuildContext context) {
    shoppingBox.refreshItems(context);
    _items = getData.reversed
        .toList(); //! Reverse the list to show latest items first
    notifyListeners();
  }

  //! Function to create a new item in the Hive box
  Future<void> createItem(BuildContext context, HiveModel newItem) async {
    await shoppingBox.createItem(context, newItem);
    notifyListeners();
    refreshItems(context);
  }

  //! Use this function to create a new item with custom key in the Hive box
  // Future<void> createItem(
  //     BuildContext context, int customKey, HiveModel newItem) async {
  //   await shoppingBox.createItem(context, customKey, newItem);
  //   notifyListeners();
  //   refreshItems(context);
  // }

  //! Function to update an existing item in the Hive box
  Future<void> updateItem(
      BuildContext context, int itemKey, HiveModel item) async {
    await shoppingBox.updateItem(context, itemKey, item);
    notifyListeners();
    refreshItems(context);
  }

  //! Function to delete an item from the Hive box
  Future<void> deleteItem(BuildContext context, int itemKey) async {
    await shoppingBox.deleteItem(context, itemKey);
    notifyListeners();
    refreshItems(context);
  }
}

//! If not using a model class,
// //
// import 'package:flutter/material.dart';
// import 'package:users_model/hive/hive_boxes/shopping_box.dart';

// class HiveProvider with ChangeNotifier {
//   final ShoppingBox shoppingBox;

//   //! List to hold the items from the Hive box
//   List<Map<String, dynamic>> _items = [];
//   late dynamic _data;

//   HiveProvider({required this.shoppingBox});

//   set setData(var value) {
//     _data = value;
//     notifyListeners();
//   }

//   get getData => _data;

//   get getItems => _items;

//   //! Function to refresh the list of items
//   void refreshItems(BuildContext context) {
//     shoppingBox.refreshItems(context);
//     _items = getData.reversed
//         .toList(); //! Reverse the list to show latest items first
//     notifyListeners();
//   }

//   //! Function to create a new item in the Hive box
//   Future<void> createItem(
//       BuildContext context, Map<String, dynamic> newItem) async {
//     await shoppingBox.createItem(context, newItem);
//     notifyListeners();
//     refreshItems(context);
//   }

//   //! Function to update an existing item in the Hive box
//   Future<void> updateItem(
//       BuildContext context, int itemKey, Map<String, dynamic> item) async {
//     await shoppingBox.updateItem(context, itemKey, item);
//     notifyListeners();
//     refreshItems(context);
//   }

//   //! Function to delete an item from the Hive box
//   Future<void> deleteItem(BuildContext context, int itemKey) async {
//     await shoppingBox.deleteItem(context, itemKey);
//     notifyListeners();
//     refreshItems(context);
//   }
// }
 