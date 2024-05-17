import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makanan/models/makan.dart';
import 'package:makanan/providers/favorit_provider.dart';

class MakananDetailsScreen extends ConsumerWidget {
  const MakananDetailsScreen({
    super.key,
    required this.makan,
  });

  final Makan makan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMakanan = ref.watch(favoritMakananProvider);

    final isFavorit = favoriteMakanan.contains(makan);
    return Scaffold(
      appBar: AppBar(
        title: Text(makan.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .watch(favoritMakananProvider.notifier)
                  .toggleMakanFavoritStatus(makan);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? 'makanan ditambah ke favorit'
                      : 'makanan dihapus dari favorit'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(
                    begin: 0.8,
                    end: 1,
                  ).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavorit ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorit),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: makan.id,
              child: Image.network(
                makan.imageUrl,
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            for (final ingredient in makan.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            for (final step in makan.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
