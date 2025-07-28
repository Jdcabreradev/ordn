import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ordn/viewmodels/item_viewmodel.dart';
import 'package:ordn/views/home/widgets/item_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.data_array_rounded, weight: 4, size: 34),
            Text(" Ordn App", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => context.push('/form'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Consumer<ItemViewmodel>(
        builder: (context, value, child) {
          if (value.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hourglass_empty, color: Colors.grey, size: 50),
                  Text(
                    "Aún no has añadido\n ninguna tarea",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: value.items.length,
              itemBuilder: (context, index) {
                final item = value.items[index];
                return ItemCard(item: item);
              },
            );
          }
        },
      ),
    );
  }
}
