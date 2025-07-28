import 'package:ordn/models/item_model.dart';

String timeRemaining(ItemModel item) {
  final now = DateTime.now();
  final diff = item.expiresAt.difference(now);
  if (diff.isNegative) return "Expirada";
  if (diff.inDays > 0) return "${diff.inDays} días";
  if (diff.inHours > 0) return "${diff.inHours} h";
  if (diff.inMinutes > 0) return "${diff.inMinutes} min";
  return "¡Pronto!";
}
