// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:users_model/models/hive_model.dart';
import 'package:users_model/providers/hive_provider.dart';
import 'package:users_model/screens/hive_crud_screen/widgets/hive_list_item.dart';

class HiveCrudScreen extends StatefulWidget {
  const HiveCrudScreen({super.key});

  @override
  State<HiveCrudScreen> createState() => HiveCrudScreenState();
}

class HiveCrudScreenState extends State<HiveCrudScreen> {
  late final HiveProvider hiveProvider;
  late final TextEditingController _nameController;
  late final TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    hiveProvider = Provider.of<HiveProvider>(context, listen: false);
    _nameController = TextEditingController();
    _quantityController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      hiveProvider.refreshItems(context);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void showForm(BuildContext context, int? itemKey) {
    if (itemKey != null) {
      final existingItem =
          hiveProvider.getItems.firstWhere((item) => item.key == itemKey);
      _nameController.text = existingItem.name;
      _quantityController.text = existingItem.quantity.toString();
    }

    showMaterialModalBottomSheet(
      context: context,
      expand: false, // Adjust as needed
      builder: (context) => SafeArea(
        child: Container(
          // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 15,
            left: 15,
            right: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                controller: _quantityController,
                decoration: const InputDecoration(
                  hintText: 'Quantity',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_nameController.text.isEmpty ||
                      _quantityController.text.isEmpty) {
                    return;
                  }

                  final String name = _nameController.text.trim();
                  final int quantity =
                      int.parse(_quantityController.text.trim());

                  if (itemKey == null) {
                    final newItem = HiveModel(name: name, quantity: quantity);
                    await hiveProvider.createItem(context, newItem);
                  } else {
                    final updatedItem =
                        HiveModel(name: name, quantity: quantity);
                    await hiveProvider.updateItem(
                        context, itemKey, updatedItem);
                  }

                  _nameController.clear();
                  _quantityController.clear();
                  Navigator.of(context).pop();
                },
                child: Text(itemKey == null ? 'Create New' : 'Update'),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveProvider>(
      builder: (context, hiveProvider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Hive'),
          ),
          body: ListView.builder(
            itemCount: hiveProvider.getItems.length,
            itemBuilder: (_, index) {
              final HiveModel currentItem = hiveProvider.getItems[index];
              return Card(
                color: Colors.orange.shade100,
                margin: const EdgeInsets.all(10),
                elevation: 3,
                child: HiveListItem(
                  hiveCrudScreenState: this,
                  currentItem: currentItem,
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showForm(context, null),
            tooltip: 'Add Item',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}


//! If not using a model class:
//
// //
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:users_model/providers/hive_provider.dart';

// import '../../models/hive_model.dart';

// class HiveCrudScreen extends StatefulWidget {
//   const HiveCrudScreen({super.key});

//   @override
//   State<HiveCrudScreen> createState() => _HiveCrudScreenState();
// }

// class _HiveCrudScreenState extends State<HiveCrudScreen> {
//   late final HiveProvider hiveProvider;
//   //! Controllers for text fields
//   late final TextEditingController _nameController;
//   late final TextEditingController _quantityController;

//   @override
//   void initState() {
//     super.initState();
//     hiveProvider = Provider.of<HiveProvider>(context, listen: false);

//     //! Initialize the controllers in initState
//     _nameController = TextEditingController();
//     _quantityController = TextEditingController();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       hiveProvider
//           .refreshItems(context); //! Load items when the screen is initialized
//     });
//   }

//   @override
//   void dispose() {
//     //! Dispose controllers to free up resources
//     _nameController.dispose();
//     _quantityController.dispose();
//     super.dispose();
//   }

//   //! Function to show the form for adding/updating an item
//   void _showForm(BuildContext context, int? itemKey) {
//     //! If itemKey is not null, populate the text fields with the existing item data
//     if (itemKey != null) {
//       final existingItem = hiveProvider.getItems
//           .firstWhere((element) => element['key'] == itemKey);
//       _nameController.text = existingItem['name'];
//       _quantityController.text = existingItem['quantity'].toString();
//     }

//     //! Show the modal bottom sheet
//     showModalBottomSheet(
//       context: context,
//       elevation: 5,
//       isScrollControlled: true,
//       builder: (_) => Container(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//           top: 15,
//           left: 15,
//           right: 15,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             //! Text field for the name
//             TextField(
//               keyboardType: TextInputType.text,
//               controller: _nameController,
//               decoration: const InputDecoration(
//                 hintText: 'Name',
//               ),
//             ),
//             const SizedBox(height: 10),
//             //! Text field for the quantity
//             TextField(
//               keyboardType: TextInputType.number,
//               controller: _quantityController,
//               decoration: const InputDecoration(
//                 hintText: 'Quantity',
//               ),
//             ),
//             const SizedBox(height: 10),
//             //! Button to create/update the item
//             ElevatedButton(
//               onPressed: () async {
//                 if (_nameController.text.isEmpty ||
//                     _quantityController.text.isEmpty) {
//                   return; //! Validate that fields are not empty
//                 }

//                 final String name = _nameController.text.trim();
//                 final int quantity = int.parse(_quantityController.text.trim());

//                 if (itemKey == null) {
//                   hiveProvider.createItem(context,
//                       {'name': name, 'quantity': quantity}); //! Create new item
//                 } else {
//                   hiveProvider.updateItem(context, itemKey, {
//                     'name': name,
//                     'quantity': quantity
//                   }); //! Update existing item
//                 }

//                 _nameController.clear(); //! Clear the text fields
//                 _quantityController.clear();
//                 Navigator.of(context).pop(); //! Close the bottom sheet
//               },
//               child: Text(itemKey == null ? 'Create New' : 'Update'),
//             ),
//             const SizedBox(height: 15),
//           ],
//         ),
//       ),
//     );
//   }

//   //! Build the UI of the screen
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HiveProvider>(
//         //! Using Consumer to rebuild parts of the UI that depend on user data
//         builder: (context, hiveProvider, child) {
//       return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text('Hive'),
//         ),
//         body: ListView.builder(
//           itemCount:
//               hiveProvider.getItems.length, //! Number of items in the list
//           itemBuilder: (_, index) {
//             final currentItem = hiveProvider.getItems[index];
//             return Card(
//               color: Colors.orange.shade100,
//               margin: const EdgeInsets.all(10),
//               elevation: 3,
//               child: ListTile(
//                 title: Text(currentItem['name']),
//                 subtitle: Text(currentItem['quantity'].toString()),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     //! Edit button
//                     IconButton(
//                       onPressed: () => _showForm(context, currentItem['key']),
//                       icon: const Icon(Icons.edit),
//                     ),
//                     //! Delete button
//                     IconButton(
//                       onPressed: () =>
//                           hiveProvider.deleteItem(context, currentItem['key']),
//                       icon: const Icon(Icons.delete),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () =>
//               _showForm(context, null), //! Show form to add new item
//           tooltip: 'Add Item',
//           child: const Icon(Icons.add),
//         ),
//       );
//     });
//   }
// }
 