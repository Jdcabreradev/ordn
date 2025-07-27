import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ordn/views/form/widgets/form_decorator.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, weight: 4, size: 24),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            Text(
              "Crear nueva tarea",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          FormDecorator(
            child: TextField(
              minLines: 1,
              maxLines: null,
              style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                constraints: BoxConstraints.expand(height: 45),
                labelText: "Nombre de la tarea ",
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
