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
    notifyListeners();
  }

  Future<void> addOrUpdateItem(ItemModel item) async {
    if (item.id == -1) {
      await _itemService.createItem(item);
    } else {
      await _itemService.updateItem(item.id, item);
    }
    await fetchItems();
  }

  Future<void> deleteItem(int id) async {
    await _itemService.deleteItem(id);
    await fetchItems();
  }
}
