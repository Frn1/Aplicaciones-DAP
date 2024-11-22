// Flutter imports:
import 'package:app_tp_final/models/shopping_item.dart';
import 'package:app_tp_final/screens/loading.dart';
import 'package:app_tp_final/shared_preferences.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:app_tp_final/providers/user.dart';
import '/providers/shopping_list.dart';
import '/router.dart';

class GroceryListScreen extends ConsumerWidget {
  const GroceryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceryListForUserProvider = groceryListProvider.call(user!);
    final groceryList = ref.watch(groceryListForUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de compras'),
        actions: [
          IconButton(
            onPressed: () async {
              user = null;
              final sharedPreferences = await getSharedPreferences();
              sharedPreferences.remove('username');
              sharedPreferences.remove('password');
              router.go('/');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: switch (groceryList) {
        AsyncData(:final value) => _loaded(value, context, ref),
        AsyncError(:final error) => Center(child: Text('Error: $error')),
        _ => const Center(child: CircularProgressIndicator()),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          router.go('/new/');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  ReorderableListView _loaded(
      List<(ShoppingItem, GlobalKey<State<StatefulWidget>>)> value,
      BuildContext context,
      WidgetRef ref) {
    return ReorderableListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          key: value[index].$2,
          leading: value[index].$1.image != null
              ? Image.network(value[index].$1.image.toString())
              : null,
          title: Text(value[index].$1.name),
          subtitle: value[index].$1.quantity.isNotEmpty
              ? Text(value[index].$1.quantity)
              : null,
          trailing: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PopupMenuButton(
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
          ),
        );
      },
      itemCount: value.length,
      onReorder: (int oldIndex, int newIndex) async {
        showDialog(
          context: context,
          builder: (context) => const LoadingScreen(),
          barrierDismissible: false,
        );
        await moveItem(ref, oldIndex, newIndex);
        if (context.mounted) {
          Navigator.pop(context);
        }
      },
    );
  }
}
