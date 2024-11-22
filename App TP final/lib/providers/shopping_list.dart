// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../models/shopping_item.dart';
import '/models/user.dart';
import '/providers/user.dart';

final groceryListProvider =
    FutureProvider.family<List<(ShoppingItem, GlobalKey)>, User>(
  (ref, user) async {
    final firestore = FirebaseFirestore.instance;
    final doc =
        await firestore.collection('grocery_lists').doc(user.username).get();
    final groceryList = doc.get('list') as List;
    return List.generate(
      groceryList.length,
      (i) => (ShoppingItem.fromMap(groceryList[i]), GlobalKey()),
      growable: true,
    );
  },
);

Future<void> addItem(WidgetRef ref, ShoppingItem item) async {
  if (user == null) {
    return;
  }

  final groceryList = groceryListProvider.call(user!);

  final firestore = FirebaseFirestore.instance;
  ref.invalidate(groceryList);
  await firestore.collection('grocery_lists').doc(user!.username).update(
    {
      'list': FieldValue.arrayUnion([item.toMap()])
    },
  );
  ref.invalidate(groceryList);
}

Future<void> removeItem(WidgetRef ref, ShoppingItem item) async {
  if (user == null) {
    return;
  }

  final groceryList = groceryListProvider.call(user!);

  final firestore = FirebaseFirestore.instance;
  ref.invalidate(groceryList);
  await firestore.collection('grocery_lists').doc(user!.username).update(
    {
      'list': FieldValue.arrayRemove([item.toMap()])
    },
  );
  ref.invalidate(groceryList);
}

Future<void> moveItem(WidgetRef ref, int oldIndex, int newIndex) async {
  if (user == null) {
    return;
  }

  final groceryList = groceryListProvider.call(user!);
  final currentGroceryList = await Future.microtask(() {
    final asyncValue = ref.read(groceryList);
    ref.invalidate(groceryList);
    while (asyncValue.isLoading) {}

    return switch (asyncValue) {
      AsyncData(:final value) => value,
      AsyncError(:final error) => throw error,
      _ => throw Error(),
    };
  });

  final firestore = FirebaseFirestore.instance;
  final newState = currentGroceryList.toList();

  final item = newState.removeAt(oldIndex);
  newState.insert(newIndex, item);

  ref.invalidate(groceryList);

  await firestore.collection('grocery_lists').doc(user!.username).update(
    {
      'list': newState
          .map(
            (e) => e.$1.toMap(),
          )
          .toList(),
    },
  );
  ref.invalidate(groceryList);
}

Future<void> editItem(WidgetRef ref, int index, ShoppingItem item) async {
  if (user == null) {
    return;
  }

  final groceryList = groceryListProvider.call(user!);
  final currentGroceryList = await Future.microtask(() {
    final asyncValue = ref.read(groceryList);
    ref.invalidate(groceryList);
    while (asyncValue.isLoading) {}

    return switch (asyncValue) {
      AsyncData(:final value) => value,
      AsyncError(:final error) => throw error,
      _ => throw Error(),
    };
  });

  final firestore = FirebaseFirestore.instance;
  final newState = currentGroceryList.map((e) => e.$1).toList();
  newState[index] = item;
  ref.invalidate(groceryList);
  await firestore.collection('grocery_lists').doc(user!.username).update(
    {
      'list': newState.map(
        (e) => e.toMap(),
      ),
    },
  );
  ref.invalidate(groceryList);
}
