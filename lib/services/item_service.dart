import 'dart:convert';
import 'package:ordn/models/item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<String>> _getRawData() async {
    final prefs = await _prefs;
    final data = prefs.getStringList('data');
    return data ?? [];
  }

  Future<int> _getNextId() async {
    final data = await _getRawData();
    return data.length + 1;
  }

  Future<void> createItem(ItemModel item) async {
    final prefs = await _prefs;
    final data = await _getRawData();
    final nextId = await _getNextId();
    final itemWithId = ItemModel(
      id: nextId,
      name: item.name,
      description: item.description,
      priority: item.priority,
      createdAt: item.createdAt,
      expiresAt: item.expiresAt,
    );
    final itemJson = jsonEncode(itemWithId.toJson());
    data.add(itemJson);
    await prefs.setStringList('data', data);
  }

  Future<void> updateItem(int id, ItemModel newItem) async {
    final prefs = await _prefs;
    final data = await _getRawData();
    final listIndex = id - 1;
    if (listIndex < 0 || listIndex >= data.length) return;
    final updatedItem = ItemModel(
      id: id,
      name: newItem.name,
      description: newItem.description,
      priority: newItem.priority,
      createdAt: newItem.createdAt,
      expiresAt: newItem.expiresAt,
    );
    data[listIndex] = jsonEncode(updatedItem.toJson());
    await prefs.setStringList('data', data);
  }

  Future<void> deleteItem(int id) async {
    final prefs = await _prefs;
    final data = await _getRawData();
    final listIndex = id - 1;
    if (listIndex < 0 || listIndex >= data.length) return;
    data.removeAt(listIndex);
    await prefs.setStringList('data', data);
  }

  Future<List<ItemModel>> getAllItems() async {
    final data = await _getRawData();
    return data.map((e) => ItemModel.fromJson(jsonDecode(e))).toList();
  }
}
