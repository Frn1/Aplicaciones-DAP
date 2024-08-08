import 'package:app_riverpod/core/providers/list_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(listProvider);
    return Scaffold(
      body: AnimatedList(
        itemBuilder: (context, index, animation) {
          return ListTile(
            title: Text(list[index]),
            trailing: PopupMenuButton(
              child: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    child: Text.rich(
                      TextSpan(
                        text: "Editar",
                        children: [
                          WidgetSpan(child: Icon(Icons.edit)),
                        ],
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                    child: Text.rich(
                      TextSpan(
                        text: "Eliminar",
                        children: [
                          WidgetSpan(child: Icon(Icons.delete_forever)),
                        ],
                      ),
                    ),
                  ),
                ];
              },
            ),
          );
        },
        initialItemCount: list.length,
      ),
    );
  }
}
