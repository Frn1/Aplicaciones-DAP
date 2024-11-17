import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/router.dart';
import '../providers/grocery_list.dart';

class NewElementDialog extends ConsumerWidget {
  final TextEditingController textController = TextEditingController();

  NewElementDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog.adaptive(
      title: const Text("Crear cosa a comprar"),
      content: TextField(
        controller: textController,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancelar",
          ),
        ),
        TextButton(
          onPressed: () {
            final newState = ref
                .read(groceryListProvider.notifier)
                .state
                .toList(); // Clone the state
            newState.add((textController.text, GlobalKey()));
            ref.read(groceryListProvider.notifier).state = newState;
            router.pop();
          },
          child: const Text(
            "Crear",
          ),
        )
      ],
    );
  }
}
