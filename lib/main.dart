import 'package:flutter/material.dart';
import 'gestor_de_tareas.dart';
import 'tarea.dart';

void main() {
  runApp(const MiAppDeTareas()); // Inicia la aplicación ejecutando MiAppDeTareas.
}

// MiAppDeTareas es un widget sin estado que crea una MaterialApp.
class MiAppDeTareas extends StatelessWidget {
  const MiAppDeTareas({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp es el widget raíz que envuelve la aplicación de Flutter.
    return const MaterialApp(
      home: PantallaDeTareas(), // Define la pantalla de inicio como PantallaDeTareas.
    );
  }
}

// PantallaDeTareas es un widget con estado que puede actualizar su interfaz cuando cambian los datos.
class PantallaDeTareas extends StatefulWidget {
  const PantallaDeTareas({super.key});

  @override
  // Crea el estado para este widget, que gestiona los datos y la interfaz.
  // ignore: library_private_types_in_public_api
  _PantallaDeTareasState createState() => _PantallaDeTareasState();
}

// Esta es la clase que contiene la lógica y la interfaz del estado de PantallaDeTareas.
class _PantallaDeTareasState extends State<PantallaDeTareas> {
  final GestorDeTareas gestorDeTareas = GestorDeTareas(); // Gestiona la lista de tareas.
  final TextEditingController controladorTexto = TextEditingController(); // Controla el texto del campo de entrada.

  void _agregarTarea() {
    setState(() {
      // Actualiza el estado de la aplicación para incluir la nueva tarea.
      gestorDeTareas.agregarTarea(Tarea(descripcion: controladorTexto.text));
      controladorTexto.clear(); // Limpia el campo de entrada después de agregar la tarea.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Construye la interfaz de usuario del widget PantallaDeTareas.
    return Scaffold(
      // Scaffold proporciona la estructura de la página, incluyendo AppBar, Body, etc.
      appBar: AppBar(title: const Text('Gestor de Tareas')), // AppBar es la barra superior de la aplicación.
      body: Column(
        // Column organiza sus hijos en vertical.
        children: [
          // El primer hijo de la columna es el campo de texto para añadir tareas.
          Padding(
            // Padding agrega espacio alrededor del campo de texto.
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              // El usuario escribe la nueva tarea aquí.
              controller: controladorTexto,
              decoration: InputDecoration(
                labelText: 'Descripción de la tarea', // Texto que indica qué hacer con el campo de texto.
                suffixIcon: IconButton(
                  // Botón para agregar la tarea.
                  icon: const Icon(Icons.add),
                  onPressed: _agregarTarea, // Agrega la tarea cuando se presiona.
                ),
              ),
              onSubmitted: (value) => _agregarTarea(), // Agrega la tarea cuando se presiona enter.
            ),
          ),
          // El segundo hijo de la columna es la lista de tareas.
          Expanded(
            // Expanded hace que la lista ocupe todo el espacio vertical restante.
            child: ListView.builder(
              // ListView.builder construye un elemento de lista por cada tarea.
              itemCount: gestorDeTareas.tareas.length, // La cantidad de elementos es la cantidad de tareas.
              itemBuilder: (context, index) {
                // Construye cada elemento de la lista.
                final tarea = gestorDeTareas.tareas[index]; // Obtiene la tarea actual basada en el índice.
                return ListTile(
                  // ListTile es un widget predefinido que representa una fila de la lista.
                  title: Text(tarea.descripcion), // Muestra la descripción de la tarea.
                  leading: IconButton(
                    // Botón para marcar la tarea como completada o pendiente.
                    icon: Icon(tarea.completada ? Icons.check_box : Icons.check_box_outline_blank),
                    onPressed: () => setState(() {
                      // Cambia el estado de la tarea cuando se presiona.
                      gestorDeTareas.marcarComoCompletada(index);
                    }),
                  ),
                  trailing: IconButton(
                    // Botón para eliminar la tarea.
                    icon: const Icon(Icons.delete),
                    onPressed: () => setState(() {
                      // Elimina la tarea cuando se presiona.
                      gestorDeTareas.eliminarTarea(index);
                    }),
                  ),
                  tileColor: tarea.completada ? Colors.green[100] : null, // Cambia el color si la tarea está completada.
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
