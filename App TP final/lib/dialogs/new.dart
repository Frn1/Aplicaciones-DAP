// Flutter imports:
import 'package:app_tp_final/models/shopping_item.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '/providers/shopping_list.dart';
import '/router.dart';

class NewElementDialog extends ConsumerWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  NewElementDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog.adaptive(
      title: const Text("Crear item"),
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
                  if (value == null || value.isEmpty) {
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
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancelar",
          ),
        ),
        TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate() == false) {
              return;
            }
            await addItem(
              ref,
              ShoppingItem(
                name: nameController.text,
                quantity: quantityController.text,
              ),
            );
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
