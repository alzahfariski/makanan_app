import 'package:flutter/material.dart';
import 'package:makanan/models/kategoris.dart';

class KategoriGridItem extends StatelessWidget {
  const KategoriGridItem(
      {super.key, required this.kategori, required this.onSelectedKategori});

  final Kategori kategori;
  final void Function() onSelectedKategori;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectedKategori,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              kategori.color.withOpacity(0.55),
              kategori.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          kategori.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
