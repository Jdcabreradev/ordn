import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ordn/models/item_model.dart';
import 'package:ordn/views/form/widgets/custom_button.dart';
import 'package:ordn/views/form/widgets/custom_expiration_picker.dart';
import 'package:ordn/views/form/widgets/custom_input.dart';
import 'package:ordn/views/form/widgets/form_decorator.dart';
import 'package:ordn/models/item_priority_enum.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late TextEditingController taskNameController;
  late TextEditingController taskDescriptionController;
  ItemPriorityEnum? taskPriority;
  DateTime? expirationDate;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    taskNameController = TextEditingController();
    taskDescriptionController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final ItemModel? existingItem =
          GoRouterState.of(context).extra as ItemModel?;

      if (existingItem != null) {
        taskNameController.text = existingItem.name;
        taskDescriptionController.text = existingItem.description;
        taskPriority = existingItem.priority;
        expirationDate = existingItem.expiresAt;
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  void setTaskPriority(ItemPriorityEnum? priority) {
    setState(() {
      taskPriority = priority;
    });
  }

  void setExpirationDate(DateTime? date) {
    setState(() {
      expirationDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ItemModel? existingItem =
        GoRouterState.of(context).extra as ItemModel?;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 24),
          onPressed: () => context.pop(),
        ),
        title: Text(
          existingItem != null ? "Editar tarea" : "Crear nueva tarea",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          FormDecorator(
            labelText: "Nombre de la tarea ",
            child: CustomInput(controller: taskNameController),
          ),
          FormDecorator(
            labelText: "Descripción de la tarea",
            child: CustomInput(controller: taskDescriptionController),
          ),
          FormDecorator(
            labelText: "Prioridad de la tarea",
            child: DropdownButton<ItemPriorityEnum>(
              value: taskPriority,
              hint: const Text("Selecciona una prioridad"),
              isExpanded: true,
              dropdownColor: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              items: ItemPriorityEnum.values.map((priority) {
                return DropdownMenuItem<ItemPriorityEnum>(
                  value: priority,
                  child: Text(
                    priority.name[0].toUpperCase() + priority.name.substring(1),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setTaskPriority(value);
              },
            ),
          ),
          FormDecorator(
            labelText: "Fecha de expiración",
            child: CustomExpirationPicker(
              selectedDate: expirationDate,
              onDateSelected: setExpirationDate,
            ),
          ),
          CustomButton(
            taskNameController: taskNameController,
            taskDescriptionController: taskDescriptionController,
            taskPriority: taskPriority,
            expirationDate: expirationDate,
            existingItem: existingItem,
          ),
        ],
      ),
    );
  }
}
