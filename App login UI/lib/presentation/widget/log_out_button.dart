import 'package:flutter/material.dart';

import '../../core/router.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            title: const Text('Confirmación'),
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 16.0,
                ),
                child: Center(
                  child: Text(
                    '¿Estás seguro que quieres cerrar sesión?',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      router.go("/login");
                    },
                    child: Text(
                      "Sí",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
      icon: const Icon(Icons.logout),
      tooltip: "Log out",
    );
  }
}
