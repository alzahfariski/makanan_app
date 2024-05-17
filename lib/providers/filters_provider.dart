import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makanan/providers/makan_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive;
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);

final filteredMakananProvider = Provider((ref) {
  final makanan = ref.watch(makananaProvider);
  final activeFilters = ref.watch(filtersProvider);
  return makanan.where((makan) {
    if (activeFilters[Filter.glutenFree]! && !makan.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !makan.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !makan.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !makan.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
