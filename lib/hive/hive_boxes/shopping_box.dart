// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:users_model/providers/hive_provider.dart';

import '../../models/hive_model.dart';

class ShoppingBox {
  //! Reference to the Hive box
  final _shoppingBox = Hive.box('shopping_box');

  //! Function to refresh the list of items
  void refreshItems(BuildContext context) {
    var hiveProvider = Provider.of<HiveProvider>(context, listen: false);

    hiveProvider.setData = _shoppingBox.keys.map((key) {
      final item =
          _shoppingBox.get(key) as HiveModel; //! Cast the item to HiveModel
      return HiveModel(
          key: key,
          name: item.name,
          quantity: item.quantity); //! Access properties directly
    }).toList();
  }

  //! Function to create a new item in the Hive box
  Future<void> createItem(BuildContext context, HiveModel newItem) async {
    try {
      await _shoppingBox.add(newItem);
      //! Display a snackbar to notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An item has been created'),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error creating item: $e');
      }
    }
  }

//! Use this function to create a new item with a custom key 
//   Future<void> createItem(BuildContext context, int customKey, HiveModel newItem) async {
//   try {
//     await _shoppingBox.put(customKey, newItem); // Use put method with customKey
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('An item has been created'),
//       ),
//     );
//   } catch (e) {
//     if (kDebugMode) {
//       print('Error creating item: $e');
//     }
//   }
// }


  //! Function to update an existing item in the Hive box
  Future<void> updateItem(
      BuildContext context, int itemKey, HiveModel item) async {
    try {
      await _shoppingBox.put(itemKey, item);
      //! Display a snackbar to notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An item has been updated'),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error updating item: $e');
      }
    }
  }

  //! Function to delete an item from the Hive box
  Future<void> deleteItem(BuildContext context, int itemKey) async {
    try {
      await _shoppingBox.delete(itemKey);
      //! Display a snackbar to notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An item has been deleted'),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting item: $e');
      }
    }
  }
}

//! If not using a model class

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:users_model/providers/hive_provider.dart';

// class ShoppingBox {
//   //! Reference to the Hive box
//   final _shoppingBox = Hive.box('shopping_box');

//   //! Function to refresh the list of items
//   void refreshItems(BuildContext context) {
//     var hiveProvider = Provider.of<HiveProvider>(context, listen: false);

//     hiveProvider.setData = _shoppingBox.keys.map((key) {
//       final item = _shoppingBox.get(key);
//       return {'key': key, 'name': item['name'], 'quantity': item['quantity']};
//     }).toList();
//   }

//   //! Function to create a new item in the Hive box
//   Future<void> createItem(BuildContext context, Map<String, dynamic> newItem) async {
//     try {
//       await _shoppingBox.add(newItem);
//       //! Display a snackbar to notify the user
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('An item has been created'),
//         ),
//       );
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error creating item: $e');
//       }
//     }
//   }

//   //! Function to update an existing item in the Hive box
//   Future<void> updateItem(BuildContext context,int itemKey, Map<String, dynamic> item) async {
//     try {
//       await _shoppingBox.put(itemKey, item);
//       //! Display a snackbar to notify the user
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('An item has been updated'),
//         ),
//       );
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error updating item: $e');
//       }
//     }
//   }

//   //! Function to delete an item from the Hive box
//   Future<void> deleteItem(BuildContext context, int itemKey) async {
//     try {
//       await _shoppingBox.delete(itemKey);
//       //! Display a snackbar to notify the user
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('An item has been deleted'),
//         ),
//       );
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error deleting item: $e');
//       }
//     }
//   }
// }
