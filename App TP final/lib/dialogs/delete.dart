import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/router.dart';
import '../providers/grocery_list.dart';

class DeleteElementDialog extends ConsumerWidget {
  final int elementIndex;

  const DeleteElementDialog({
    super.key,
    required this.elementIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final element = ref.read(groceryListProvider)[elementIndex];
    final name = element.$1;

    return AlertDialog.adaptive(
      title: Text("Eliminar \"$name\""),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () {
            router.pop();
            final newState = ref
                .read(groceryListProvider.notifier)
                .state
                .toList(); // Clone the state
            newState.removeAt(elementIndex);
            ref.read(groceryListProvider.notifier).state = newState;
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
