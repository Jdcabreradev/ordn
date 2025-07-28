import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ordn/viewmodels/item_viewmodel.dart';
import 'package:ordn/models/item_model.dart';
import 'package:ordn/models/item_priority_enum.dart';

class CustomButton extends StatelessWidget {
  final String taskName;
  final String taskDescription;
  final ItemPriorityEnum? taskPriority;
  final DateTime? expirationDate;
  final ItemModel? existingItem;
  const CustomButton({
    super.key,
    required this.taskName,
    required this.taskDescription,
    required this.taskPriority,
    required this.expirationDate,
    this.existingItem,
  });

  bool get _isFormValid {
    return taskName.trim().isNotEmpty &&
        taskDescription.trim().isNotEmpty &&
        taskPriority != null &&
        expirationDate != null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: _isFormValid ? () => _handleSubmit(context) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isFormValid ? Colors.black : Colors.grey,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          existingItem != null ? 'Actualizar Tarea' : 'Crear Tarea',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future<void> _handleSubmit(BuildContext context) async {
    if (!_isFormValid) return;

    final itemViewmodel = context.read<ItemViewmodel>();

    if (existingItem != null) {
      // Update existing item
      await itemViewmodel.addOrUpdateItem(
        ItemModel(
          id: existingItem!.id,
          name: taskName,
          description: taskDescription,
          priority: taskPriority!,
          createdAt: existingItem!.createdAt,
          expiresAt: expirationDate!,
        ),
      );
    } else {
      // Create new item
      await itemViewmodel.addOrUpdateItem(
        ItemModel(
          id: -1,
          name: taskName,
          description: taskDescription,
          priority: taskPriority!,
          createdAt: DateTime.now(),
          expiresAt: expirationDate!,
        ),
      );
      context.pop();
      print("create new item");
    }
  }
}
