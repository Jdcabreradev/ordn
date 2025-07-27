import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ordn/viewmodels/item_viewmodel.dart';
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
            return Center(child: Text("No items available"));
          } else {
            return ListView.builder(
              itemCount: value.items.length,
              itemBuilder: (context, index) {
                final item = value.items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.description),
                  onTap: () => context.push('/details'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
