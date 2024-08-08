import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/providers/list_provider.dart';

class NewElementDialog extends ConsumerWidget {
  final int elementIndex;
  final TextEditingController textController = TextEditingController();

  NewElementDialog({
    super.key,
    required this.elementIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialText = ref.watch(listProvider)[elementIndex];
    textController.text = initialText;

    return NavigatorPopHandler(
      onPop: () {
        ref.read(listProvider)[elementIndex] = textController.text;
      },
      child: AlertDialog.adaptive(
        title: const Text("Crear elemento"),
        content: TextField(
          controller: textController,
        ),
        actions: [
          TextButton(
            onPressed: () {
              textController.text = initialText;
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancelar",
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Crear",
            ),
          )
        ],
      ),
    );
  }
}
