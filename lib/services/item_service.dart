import 'dart:convert';
import 'package:ordn/models/item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<String>> _getRawData() async {
    final prefs = await _prefs;
    return prefs.getStringList('data') ?? [];
  }

  Future<int> _getNextId() async {
    final data = await _getRawData();
    if (data.isEmpty) return 1;

    int maxId = 0;
    for (String itemJson in data) {
      final id = jsonDecode(itemJson)['id'] as int;
      if (id > maxId) maxId = id;
    }
    return maxId + 1;
  }

  int _findItemIndex(List<String> data, int id) {
    for (int i = 0; i < data.length; i++) {
      if (jsonDecode(data[i])['id'] == id) return i;
    }
    return -1;
  }

  Future<void> createItem(ItemModel item) async {
    final prefs = await _prefs;
    final data = await _getRawData();
    final itemWithId = ItemModel(
      id: await _getNextId(),
      name: item.name,
      description: item.description,
      priority: item.priority,
      createdAt: item.createdAt,
      expiresAt: item.expiresAt,
    );
    data.add(jsonEncode(itemWithId.toJson()));
    await prefs.setStringList('data', data);
  }

  Future<void> updateItem(int id, ItemModel newItem) async {
    final prefs = await _prefs;
    final data = await _getRawData();
    final index = _findItemIndex(data, id);

    if (index == -1) return;

    final updatedItem = ItemModel(
      id: id,
      name: newItem.name,
      description: newItem.description,
      priority: newItem.priority,
      createdAt: newItem.createdAt,
      expiresAt: newItem.expiresAt,
    );
    data[index] = jsonEncode(updatedItem.toJson());
    await prefs.setStringList('data', data);
  }

  Future<void> deleteItem(int id) async {
    final prefs = await _prefs;
    final data = await _getRawData();
    final index = _findItemIndex(data, id);

    if (index != -1) {
      data.removeAt(index);
      await prefs.setStringList('data', data);
    }
  }

  Future<List<ItemModel>> getAllItems() async {
    final data = await _getRawData();
    List<ItemModel> items = [];

    for (String itemJson in data) {
      items.add(ItemModel.fromJson(jsonDecode(itemJson)));
    }

    items.sort((a, b) => a.expiresAt.compareTo(b.expiresAt));
    return items;
  }
}
