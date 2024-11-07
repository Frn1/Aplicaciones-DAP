import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/list.dart';

class EditElementDialog extends ConsumerWidget {
  final int elementIndex;
  final TextEditingController textController = TextEditingController();

  EditElementDialog({
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
        title: Text("Editar elemento \"$initialText\""),
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
              "Guardar",
            ),
          )
        ],
      ),
    );
  }
}
