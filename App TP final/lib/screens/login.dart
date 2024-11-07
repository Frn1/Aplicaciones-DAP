import 'package:app_tp_final/screens/loading.dart';
import 'package:flutter/material.dart';
import '/models/user.dart';
import '/router.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  // Controlador para el nombre de usuario para poder leer el texto dentro de la caja
  final userController = TextEditingController();
  // Controlador para la contraseña para poder leer el texto dentro de la caja
  final passController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
        centerTitle: true,
      ),
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

                  onPressed: () async {
                    var username = userController.text;
                    var password = passController.text;

                    // El usuario está vacio
                    if (username.isEmpty) {
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(
                          // Mostrar mensajito abajo
                          const SnackBar(
                            content: Text("El usuario no puede estar vacío"),
                          ),
                        );
                      print('Username is empty');
                      return;
                    }

                    // La contraseña está vacia
                    if (password.isEmpty) {
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text("La contraseña no puede estar vacía"),
                          ),
                        );
                      print('Password is empty');
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (context) => const LoadingScreen(),
                      barrierDismissible: false,
                      useSafeArea: false,
                    );

                    final user = User(username, password);

                    try {
                      if (user == await User.getFromFirebase(username)) {
                        // El usuario y contraseña están bien
                        print('Welcome, $username');
                        router.go('/', extra: username);
                      } else {
                        // El usuario o contraseña están mal
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            const SnackBar(
                              content: Text("Usuario o contraseña incorrecta"),
                            ),
                          );
                        print('Wrong username or password');
                      }
                    } catch (e) {
                      // El usuario o contraseña están mal
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(
                          const SnackBar(
                            content:
                                Text("Ocurrió un error intentando logearte!"),
                          ),
                        );
                      print('Error logging in user\n$e');
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
