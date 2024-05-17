import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makanan/models/makan.dart';

class FavoritMakananNotifier extends StateNotifier<List<Makan>> {
  FavoritMakananNotifier() : super([]);

  bool toggleMakanFavoritStatus(Makan makan) {
    final makanIsFavorite = state.contains(makan);

    if (makanIsFavorite) {
      state = state.where((m) => m.id != makan.id).toList();
      return false;
    } else {
      state = [...state, makan];
      return true;
    }
  }
}

final favoritMakananProvider =
    StateNotifierProvider<FavoritMakananNotifier, List<Makan>>((ref) {
  return FavoritMakananNotifier();
});
