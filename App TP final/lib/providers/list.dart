import 'package:flutter_riverpod/flutter_riverpod.dart';

final listProvider = StateProvider<List<String>>(
  (ref) => [],
);
