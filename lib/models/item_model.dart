import 'package:ordn/models/item_priority_enum.dart';

class ItemModel {
  final String name;
  final String description;
  final ItemPriorityEnum priority;
  final DateTime createdAt;
  final DateTime expiresAt;

  ItemModel({
    required this.name,
    required this.description,
    required this.priority,
    required this.createdAt,
    required this.expiresAt,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      name: json['name'] as String,
      description: json['description'] as String,
      priority: ItemPriorityEnum.values.firstWhere(
        (e) => e.name == json['priority'],
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'priority': priority.name,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
    };
  }
}
