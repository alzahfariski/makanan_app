import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makanan/providers/favorit_provider.dart';
import 'package:makanan/screens/filters.dart';
import 'package:makanan/screens/kategori.dart';
import 'package:makanan/screens/makanan.dart';
import 'package:makanan/widgets/main_drawer.dart';
import 'package:makanan/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String indentifier) async {
    Navigator.of(context).pop();
    if (indentifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availabelMeals = ref.watch(filteredMakananProvider);

    Widget activePage = KategoriScreen(
      availabelMeals: availabelMeals,
    );
    var activePageTitle = 'Kategori';

    if (_selectedPageIndex == 1) {
      final favoriteMakanan = ref.watch(favoritMakananProvider);
      activePage = MakananScreen(
        makanan: favoriteMakanan,
      );
      activePageTitle = 'Favorit';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorit',
          ),
        ],
      ),
    );
  }
}
