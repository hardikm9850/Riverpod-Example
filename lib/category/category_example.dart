import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers.dart';

// Article : https://bartvwezel.nl/flutter/flutter-riverpod-example-category-selection/
void main() {
  runApp(const ProviderScope(child: MultipleCategorySelection()));
}

class MultipleCategorySelection extends StatelessWidget {
  const MultipleCategorySelection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Interactive categories")),
        body: Column(
          children: [
            const CategoryFilter(),
            Container(
              color: Colors.green,
              height: 2,
            ),
            const SelectedCategories()
          ],
        ),
      ),
    );
  }
}

void toggleCheckBox(WidgetRef ref, Category value) {
  var notifier = ref.read(categoryListProvider.notifier);
  notifier.toggle(value);
}

class CategoryFilter extends HookConsumerWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("\n1");
    final selectedCategoryList = ref.watch(selectedCategoriesProvider);
    final categoryList = ref.watch(allCategories);

    final notifier = ref.watch(categoryListProvider.notifier);

    return Flexible(
      child: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              key: Key(categoryList[index].name),
              value: selectedCategoryList.contains(categoryList[index]),
              onChanged: (bool? selected) {
                notifier.toggle(categoryList[index]);
              },
              title: ProviderScope(overrides: [
                selectedCategory.overrideWithValue(categoryList[index])
              ], child: CategoryWidget()),
            );
          }),
    );
  }
}

class SelectedCategories extends HookConsumerWidget {
  const SelectedCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryList = ref.watch(selectedCategoriesProvider);
    return Flexible(
      child: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProviderScope(overrides: [
                  selectedCategory.overrideWithValue(categoryList[index])
                ], child: CategoryWidget()));
          }),
    );
  }
}

class CategoryWidget extends HookConsumerWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(selectedCategory);
    if (category != null) {
      return Text(
        category.name,
        style: TextStyle(color: category.color),
      );
    }
    return Container();
  }
}

CategoryListStateNotifier createCategoryList(List<Category> values) {
  final Map<Category, bool> categories = <Category, bool>{};
  for (var value in values) {
    categories.putIfAbsent(value, () => false);
  }
  return CategoryListStateNotifier(categories);
}

@immutable
class Category {
  final String name;
  final Color color;

  const Category(this.name, this.color);

  @override
  String toString() {
    return "name : $name, color : $color";
  }
}
