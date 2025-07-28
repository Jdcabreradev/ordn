import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomExpirationPicker extends StatelessWidget {
  final DateTime? selectedDate;
  final void Function(DateTime? date) onDateSelected;

  const CustomExpirationPicker({
    super.key,
    this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? now,
          firstDate: now,
          lastDate: DateTime(now.year + 5),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  surface: Colors.black,
                  onSurface: Colors.white,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                ),
                dialogTheme: DialogThemeData(backgroundColor: Colors.black),
              ),
              child: child!,
            );
          },
        );

        if (picked != null && context.mounted) {
          final time = await showTimePicker(
            context: context,
            initialTime: selectedDate != null
                ? TimeOfDay.fromDateTime(selectedDate!)
                : TimeOfDay.fromDateTime(now),
            builder: (context, child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    surface: Colors.black,
                    onSurface: Colors.white,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                  ),
                  dialogTheme: DialogThemeData(backgroundColor: Colors.black),
                ),
                child: child!,
              );
            },
          );

          if (time != null && context.mounted) {
            final expiration = DateTime(
              picked.year,
              picked.month,
              picked.day,
              time.hour,
              time.minute,
            );
            onDateSelected(expiration);
          }
        }
      },
      child: Text(
        selectedDate != null
            ? DateFormat('dd/MM/yyyy HH:mm').format(selectedDate!)
            : "Selecciona fecha y hora",
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
