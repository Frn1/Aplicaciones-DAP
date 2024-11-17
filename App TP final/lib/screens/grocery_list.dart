import '/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/grocery_list.dart';

class GroceryListScreen extends ConsumerWidget {
  const GroceryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(groceryListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de compras'),
      ),
      body: ReorderableListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            key: list[index].$2,
            title: Text(list[index].$1),
            trailing: PopupMenuButton(
              child: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: const ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Editar'),
                    ),
                    onTap: () {
                      router.go('/edit/$index');
                    },
                  ),
                  PopupMenuItem(
                    child: const ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Eliminar'),
                    ),
                    onTap: () {
                      router.go('/delete/$index');
                    },
                  ),
                ];
              },
            ),
          );
        },
        itemCount: list.length,
        onReorder: (int oldIndex, int newIndex) {
          final newState = ref
              .read(groceryListProvider.notifier)
              .state
              .toList(); // Clone the state
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = newState.removeAt(oldIndex);
          newState.insert(newIndex, item);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          router.go('/new/');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
