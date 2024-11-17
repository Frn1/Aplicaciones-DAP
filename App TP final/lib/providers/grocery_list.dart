import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groceryListProvider = StateProvider<List<(String, GlobalKey)>>(
  (ref) => [],
);
