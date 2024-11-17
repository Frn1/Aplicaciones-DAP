import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/router.dart';
import '../providers/grocery_list.dart';

class EditElementDialog extends ConsumerWidget {
  final int elementIndex;
  final TextEditingController textController = TextEditingController();

  EditElementDialog({
    super.key,
    required this.elementIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialElement = ref.read(groceryListProvider)[elementIndex];
    final initialText = initialElement.$1;
    textController.text = initialText;

    return AlertDialog.adaptive(
      title: Text("Editar \"$initialText\""),
      content: TextField(
        controller: textController,
      ),
      actions: [
        TextButton(
          onPressed: () {
            router.pop();
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
            newState[elementIndex] = (
              textController.text,
              newState[elementIndex].$2,
            );
            ref.read(groceryListProvider.notifier).state = newState;
            router.pop();
          },
          child: const Text(
            "Guardar",
          ),
        ),
      ],
    );
  }
}
