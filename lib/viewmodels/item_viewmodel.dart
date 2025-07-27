import 'package:flutter/material.dart';
import 'package:ordn/services/item_service.dart';
import 'package:ordn/models/item_model.dart';

class ItemViewmodel extends ChangeNotifier {
  final ItemService _itemService = ItemService();
  List<ItemModel> _items = [];

  List<ItemModel> get items => _items;

  ItemViewmodel() {
    fetchItems();
  }

  Future<void> fetchItems() async {
    _items = await _itemService.getAllItems();
    if (_items.isNotEmpty) {
      notifyListeners();
    }
  }

  Future<void> addItem(ItemModel item) async {
    await _itemService.createItem(item);
    _items.add(item);
    notifyListeners();
  }

  Future<void> updateItem(int id, ItemModel item) async {
    await _itemService.updateItem(id, item);
    final index = _items.indexWhere((e) => e.id == id);
    if (index != -1) {
      _items[index] = item;
    }
    notifyListeners();
  }

  Future<void> deleteItem(int id) async {
    await _itemService.deleteItem(id);
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
