import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makanan/data/dummy_data.dart';

final makananaProvider = Provider((ref) {
  return dummyMeals;
});
