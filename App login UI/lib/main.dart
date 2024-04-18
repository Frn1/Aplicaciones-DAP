import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

// ignore: must_be_immutable
class MainApp extends StatelessWidget {
  // Controlador para el nombre de usuario para poder leer el texto dentro de la caja
  final userController = TextEditingController();
  // Controlador para la contraseña para poder leer el texto dentro de la caja
  final passController = TextEditingController();

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // Hacegurarme que no se me corte la app por algun borde o algo así
        body: SafeArea(
          child: Padding(
            // Poner un poco de espacio vacio en los costados
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              // Expandir el Column al ancho máximo posible
              // utilizando un SizedBox (literalmente "caja con tamaño" en Inglés)
              width: double.infinity,
              child: Column(
                // Poner las cosas en el centro
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Caja de texto para el nombre de usuario
                  TextField(
                    // Controller para el texto del nombre de usuario
                    controller: userController,
                    decoration: const InputDecoration(
                      // Ícono para el nombre de usuario
                      prefixIcon: Icon(Icons.person_2_rounded),
                      // Borde de la caja de texto
                      border: OutlineInputBorder(),
                      // Texto que aparece cuando la caja está vacia
                      hintText: "Username",
                    ),
                  ),
                  // Agregar un poco de espacio vertical entre las cajas de texto
                  // utilizando un SizedBox
                  const SizedBox(
                    height: 10,
                  ),
                  // Caja de texto para la contraseña
                  TextField(
                    // Controller para la contraseña
                    controller: passController,
                    // Decirle a la caja del texto que esconda la contraseña
                    // (Le decimos que ponga los puntitos)
                    obscureText: true,
                    decoration: const InputDecoration(
                      // Ícono para el nombre de usuario
                      prefixIcon: Icon(Icons.key),
                      // Borde de la caja de texto
                      border: OutlineInputBorder(),
                      // Texto que aparece cuando la caja está vacia
                      hintText: "Password",
                    ),
                  ),
                  // Agregar un poco de espacio vertical entre las cajas de texto
                  // y el botón de log in utilizando un SizedBox
                  const SizedBox(
                    height: 20,
                  ),
                  // Boton de log in
                  FilledButton(
                    onPressed: () {
                      if (userController.text.isEmpty) {
                        // El usuario está vacio
                        print('Username is empty');
                        return;
                      }
                      if (passController.text.isEmpty) {
                        // La contraseña está vacia
                        print('Password is empty');
                        return;
                      }
                      if (userController.text != 'AlanTej' ||
                          passController.text != '123abc') {
                        // El usuario o contraseña están mal
                        print('Wrong username or password');
                      } else {
                        // El usuario y contraseña están bien
                        print('Welcome, AlanTej');
                      }
                    },
                    // Para poner más de una cosa dentro del botón
                    // pongo un Row
                    child: const Row(
                      // Si no le digo que se achique al mínimo tamaño posible
                      // me hace un botón gigantesco que va hasta el final
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Texto del botón
                        Text(
                          'Log in',
                        ),
                        // Un poquito de espacio horizontal usando SizedBox
                        SizedBox(
                          width: 5,
                        ),
                        // El ícono de login
                        Icon(
                          Icons.login,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
