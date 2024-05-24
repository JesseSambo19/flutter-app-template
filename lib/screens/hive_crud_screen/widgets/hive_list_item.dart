import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_model/providers/hive_provider.dart';
import 'package:users_model/screens/hive_crud_screen/hive_crud_screen.dart';

import '../../../models/hive_model.dart';

class HiveListItem extends StatefulWidget {
  const HiveListItem({super.key, required this.currentItem, required this.hiveCrudScreenState});

  final HiveCrudScreenState hiveCrudScreenState;
  final HiveModel currentItem;

  @override
  State<HiveListItem> createState() => _HiveListItemState();
}

class _HiveListItemState extends State<HiveListItem> {
  @override
  Widget build(BuildContext context) {
    HiveProvider hiveProvider = Provider.of<HiveProvider>(context);
    return ListTile(
      title: Text(widget.currentItem.name),
      subtitle: Text(widget.currentItem.quantity.toString()),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => widget.hiveCrudScreenState.showForm(context, widget.currentItem.key),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () =>
                hiveProvider.deleteItem(context, widget.currentItem.key!),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
