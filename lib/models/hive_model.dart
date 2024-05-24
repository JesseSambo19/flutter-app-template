import 'package:hive/hive.dart';

part '../hive/hive_adapters/hive_model.g.dart';

@HiveType(typeId: 0)
class HiveModel extends HiveObject {
  @override
  //! Optional key parameter
  @HiveField(0)
  final int? key;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int quantity;

  HiveModel({
    this.key, //! Key is optional
    required this.name,
    required this.quantity,
  });

  factory HiveModel.fromJson(Map<String, dynamic> json) {
    return HiveModel(
      key: json['key'], //! Assign the key if it exists in the JSON
      name: json['name'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'quantity': quantity,
    };
    if (key != null) {
      data['key'] = key;
    }
    return data;
  }
}
