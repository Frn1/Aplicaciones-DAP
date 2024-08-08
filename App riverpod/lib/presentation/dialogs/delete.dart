import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/providers/list_provider.dart';

class DeleteElementDialog extends ConsumerWidget {
  final int elementIndex;

  const DeleteElementDialog({
    super.key,
    required this.elementIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(listProvider)[elementIndex];

    return AlertDialog.adaptive(
      title: Text("Eliminar elemento \"$name\""),
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
            ref.read(listProvider).removeAt(elementIndex);
            Navigator.of(context).pop();
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
