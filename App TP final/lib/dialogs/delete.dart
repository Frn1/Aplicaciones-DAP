// Flutter imports:
import 'package:app_tp_final/models/shopping_item.dart';
import 'package:app_tp_final/providers/user.dart';
import 'package:app_tp_final/screens/loading.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '/providers/shopping_list.dart';
import '/router.dart';

class DeleteElementDialog extends ConsumerWidget {
  final int elementIndex;

  const DeleteElementDialog({
    super.key,
    required this.elementIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingListActivity = ref.watch(groceryListProvider.call(user!));

    return switch (shoppingListActivity) {
      AsyncData(:final value) => _loaded(value[elementIndex].$1, context, ref),
      AsyncError(:final error) => AlertDialog(
          title: const Text('Error!'),
          content: Text('$error'),
        ),
      _ => const LoadingScreen(),
    };
  }

  AlertDialog _loaded(
    ShoppingItem item,
    BuildContext context,
    WidgetRef ref,
  ) {
    final name = item.name;
    return AlertDialog(
      title: Text("Eliminar \"$name\""),
      actions: [
        TextButton(
          onPressed: () {
            router.pop();
          },
          child: const Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () async {
            await removeItem(ref, item);
            router.pop();
          },
          child: const Text(
            "Sí",
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
        )
      ],
    );
  }
}
