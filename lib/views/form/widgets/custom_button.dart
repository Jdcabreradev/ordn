import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ordn/viewmodels/item_viewmodel.dart';
import 'package:ordn/models/item_model.dart';
import 'package:ordn/models/item_priority_enum.dart';

class CustomButton extends StatelessWidget {
  final TextEditingController taskNameController;
  final TextEditingController taskDescriptionController;
  final ItemPriorityEnum? taskPriority;
  final DateTime? expirationDate;
  final ItemModel? existingItem;

  const CustomButton({
    super.key,
    required this.taskNameController,
    required this.taskDescriptionController,
    required this.taskPriority,
    required this.expirationDate,
    this.existingItem,
  });

  bool get _isFormValid {
    return taskNameController.text.trim().isNotEmpty &&
        taskDescriptionController.text.trim().isNotEmpty &&
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
      await itemViewmodel.addOrUpdateItem(
        ItemModel(
          id: existingItem!.id,
          name: taskNameController.text.trim(),
          description: taskDescriptionController.text.trim(),
          priority: taskPriority!,
          createdAt: existingItem!.createdAt,
          expiresAt: expirationDate!,
        ),
      );
    } else {
      await itemViewmodel.addOrUpdateItem(
        ItemModel(
          id: -1,
          name: taskNameController.text.trim(),
          description: taskDescriptionController.text.trim(),
          priority: taskPriority!,
          createdAt: DateTime.now(),
          expiresAt: expirationDate!,
        ),
      );
    }

    if (context.mounted) {
      context.pop();
    }
  }
}
