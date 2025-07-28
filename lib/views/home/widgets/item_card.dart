import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ordn/models/item_model.dart';
import 'package:ordn/models/item_priority_enum.dart';
import 'package:intl/intl.dart';
import 'package:ordn/utils/time_remaining.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;

  const ItemCard({super.key, required this.item});

  Color _priorityColor(ItemPriorityEnum priority) {
    switch (priority) {
      case ItemPriorityEnum.bajo:
        return Colors.green;
      case ItemPriorityEnum.medio:
        return Colors.orange;
      case ItemPriorityEnum.alto:
        return Colors.red;
      case ItemPriorityEnum.urgente:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/details', extra: item),
      child: Card(
        color: Colors.grey[200],
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: SizedBox(
          height: 110,
          child: Row(
            children: [
              Container(
                width: 8,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: _priorityColor(item.priority),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const SizedBox(height: 6),
                      Text(
                        item.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Creado: ${DateFormat('dd/MM/yyyy HH:mm').format(item.createdAt)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withAlpha((0.45 * 255).toInt()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 30,
                    color: Colors.black45,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    timeRemaining(item),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withAlpha((0.6 * 255).toInt()),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
            ],
          ),
        ),
      ),
    );
  }
}
