import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'category_example.dart';

final categoryListProvider =
    StateNotifierProvider<CategoryListStateNotifier, Map<Category, bool>>(
        (_) => createCategoryList([
              Category("Apple", Colors.red[700]!),
              Category("Orange", Colors.orange[700]!),
              Category("Banana", Colors.yellow[700]!)
            ]));

final selectedCategoriesProvider = Provider((ref) => ref
    .watch(categoryListProvider)
    .entries
    .where((element) => element.value)
    .map((e) => e.key)
    .toList());

final allCategories =
    Provider((ref) => ref.watch(categoryListProvider).keys.toList());

final selectedCategory = Provider<Category?>((ref) => null);

class CategoryListStateNotifier extends StateNotifier<Map<Category, bool>> {
  CategoryListStateNotifier(Map<Category, bool> state) : super(state);

  void toggle(Category item) {
    Map<Category,bool> newResult = {};
    for (var element in state.entries) {
      if(element.key.name == item.name) {
        newResult.putIfAbsent(element.key, () => !element.value);
      } else {
        newResult.putIfAbsent(element.key, () => element.value);
      }
    }
    state = newResult;
  }
}

///---------

class ItemListService extends StateNotifier<Map<Category, bool>> {
  ItemListService(Map<Category, bool> state) : super(state);

  void toggle(Category item) {
    final currentValue = state[item];
    if (currentValue != null) {
      state[item] = !currentValue;
      state = state;
    }
  }
}

final itemListNotifier =
    StateNotifierProvider<ItemListService, Map<Category, bool>>(
        (ref) => createItemList([
              Category("Apple", Colors.red[700]!),
              Category("Orange", Colors.orange[700]!),
              Category("Banana", Colors.yellow[700]!)
            ]));

ItemListService createItemList(List<Category> values) {
  final Map<Category, bool> categories = <Category, bool>{};
  for (var value in values) {
    categories.putIfAbsent(value, () => false);
  }
  return ItemListService(categories);
}
