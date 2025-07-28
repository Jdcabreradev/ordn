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

  Future<void> addOrUpdateItem(ItemModel item) async {
    await _itemService.updateItem(item.id, item);
    final index = _items.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      print("item updated");
      _items[index] = item;
    }
    print("item created");
    notifyListeners();
  }

  Future<void> deleteItem(int id) async {
    await _itemService.deleteItem(id);
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
