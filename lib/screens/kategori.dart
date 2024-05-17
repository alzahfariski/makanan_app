import 'package:flutter/material.dart';
import 'package:makanan/data/dummy_data.dart';
import 'package:makanan/models/kategoris.dart';
import 'package:makanan/models/makan.dart';
import 'package:makanan/screens/makanan.dart';
import 'package:makanan/widgets/kategori_grid_item.dart';

class KategoriScreen extends StatefulWidget {
  const KategoriScreen({
    super.key,
    required this.availabelMeals,
  });

  final List<Makan> availabelMeals;

  @override
  State<KategoriScreen> createState() => _KategoriScreenState();
}

class _KategoriScreenState extends State<KategoriScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectedKategori(BuildContext context, Kategori kategori) {
    final filteredMakanan = widget.availabelMeals
        .where((makan) => makan.categories.contains(kategori.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MakananScreen(
          title: kategori.title,
          makanan: filteredMakanan,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final kategori in availableCategories)
            KategoriGridItem(
              kategori: kategori,
              onSelectedKategori: () {
                _selectedKategori(context, kategori);
              },
            )
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
