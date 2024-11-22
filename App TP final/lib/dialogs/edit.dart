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

class EditElementDialog extends ConsumerWidget {
  final int elementIndex;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  EditElementDialog({
    super.key,
    required this.elementIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Would prefer to use read in here, but oh well...
    final shoppingListActivity = ref.watch(groceryListProvider.call(user!));

    return switch (shoppingListActivity) {
      AsyncData(:final value) => _loaded(value[elementIndex].$1, ref),
      AsyncError(:final error) => AlertDialog(
          title: const Text('Error!'),
          content: Text('$error'),
        ),
      _ => const LoadingScreen(),
    };
  }

  AlertDialog _loaded(ShoppingItem initialItem, WidgetRef ref) {
    nameController.text = initialItem.name;
    quantityController.text = initialItem.quantity;
    return AlertDialog.adaptive(
      title: Text("Editar \"${initialItem.name}"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 70,
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El nombre no puede estar vacio';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 70,
              child: TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: 'Cantidad',
                ),
              ),
            ),
          ],
        ),
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
          onPressed: () async {
            await editItem(
              ref,
              elementIndex,
              ShoppingItem(
                name: nameController.text.trim(),
                quantity: quantityController.text.trim(),
              ),
            );
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
