import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ordn/models/item_model.dart';
import 'package:ordn/models/item_priority_enum.dart';
import 'package:intl/intl.dart';
import 'package:ordn/viewmodels/item_viewmodel.dart';
import 'package:provider/provider.dart';

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

  String _timeRemaining() {
    final now = DateTime.now();
    final diff = item.expiresAt.difference(now);
    if (diff.isNegative) return "Expirada";
    if (diff.inDays > 0) return "${diff.inDays} días";
    if (diff.inHours > 0) return "${diff.inHours} h";
    if (diff.inMinutes > 0) return "${diff.inMinutes} min";
    return "¡Pronto!";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/details'),
      child: Card(
        color: Colors.grey[200],
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: SizedBox(
          height: 125,
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
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.black45,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _timeRemaining(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withAlpha(
                                (0.6 * 255).toInt(),
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.description,
                        maxLines: 2,
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
              IconButton(
                icon: const Icon(Icons.check_circle),
                iconSize: 36,
                onPressed: () =>
                    context.read<ItemViewmodel>().deleteItem(item.id),
                tooltip: 'Marcar como completada',
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
