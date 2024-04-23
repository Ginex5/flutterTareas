import 'package:flutter/material.dart';
import 'gestor_tareas/gestor_de_tareas.dart';
import 'tarea/tarea.dart';

void main() {
  runApp(
      const MiAppDeTareas());
}

class MiAppDeTareas extends StatelessWidget {
  const MiAppDeTareas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Tareas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const PantallaDeTareas(
          title:
              'Gestor Tareas'), // Define la pantalla de inicio como PantallaDeTareas.
    );
  }
}

// PantallaDeTareas es un widget con estado que puede actualizar su interfaz cuando cambian los datos.
class PantallaDeTareas extends StatefulWidget {
  const PantallaDeTareas({super.key, required this.title});

  final String title;

  @override
  State<PantallaDeTareas> createState() => _PantallaDeTareasState();
}

// Esta es la clase que contiene la lógica y la interfaz del estado de PantallaDeTareas.
class _PantallaDeTareasState extends State<PantallaDeTareas> {
  final GestorDeTareas gestorDeTareas =
      GestorDeTareas(); // Gestiona la lista de tareas.
  final TextEditingController controladorTexto =
      TextEditingController(); // Controla el texto del campo de entrada.

  void _agregarTarea() {
    setState(() {
      gestorDeTareas.agregarTarea(Tarea(descripcion: controladorTexto.text));
      controladorTexto
          .clear(); // Limpia el campo de entrada después de agregar la tarea.
    });
  }

  void _eliminarTarea(int index) {
    setState(() {
      gestorDeTareas.eliminarTarea(index);
    });
  }

  void _marcarTareaComoCompletada(int index) {
    setState(() {
      gestorDeTareas.marcarComoCompletada(index);
    });
  }

  void _modificarTarea(int index, String nuevaDescripcion) {
    setState(() {
      gestorDeTareas.tareas[index].descripcion = nuevaDescripcion;
    });
  }

  void _mostrarDialogoDeConfirmacionEliminacion(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar'),
          content:
              const Text('¿Estás seguro de que quieres eliminar esta tarea?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Cierra el diálogo sin hacer nada más
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _eliminarTarea(index);
                Navigator.of(context).pop();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoDeModificacion(int index) {
    final controladorTextoModificado = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modificar Tarea'),
          content: TextField(
            controller: controladorTextoModificado,
            decoration: const InputDecoration(
                hintText: "Nueva descripción de la tarea"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _modificarTarea(index, controladorTextoModificado.text);
                Navigator.of(context).pop();
              },
              child: const Text('Modificar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFieldTarea() {
    return TextField(
      controller: controladorTexto,
      decoration: InputDecoration(
        labelText:
            'Descripción de la tarea', // Texto que indica qué hacer con el campo de texto.
        suffixIcon: IconButton(
          // Botón para agregar la tarea.
          icon: const Icon(Icons.add),
          onPressed: _agregarTarea, // Agrega la tarea cuando se presiona.
        ),
      ),
      onSubmitted: (value) =>
          _agregarTarea(), // Agrega la tarea cuando se presiona enter.
    );
  }

  Widget _buildItemListaTarea(Tarea tarea, int index) {
    return ListTile(
      title: Text(tarea.descripcion), // Muestra la descripción de la tarea.
      leading: IconButton(
          // Botón para marcar la tarea como completada o pendiente.
          icon: Icon(tarea.completada
              ? Icons.check_box
              : Icons.check_box_outline_blank),
          onPressed: () => _marcarTareaComoCompletada(index)),
      trailing: Row(
        mainAxisSize: MainAxisSize
            .min, // Esto asegura que los iconos se mantengan juntos.
        children: [
          IconButton(
            icon: const Icon(Icons.edit), // Icono de edición/modificación.
            onPressed: () => _mostrarDialogoDeModificacion(index),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _mostrarDialogoDeConfirmacionEliminacion(index),
          ),
        ],
      ),
      tileColor: tarea.completada
          ? Colors.green[100]
          : null, // Cambia el color si la tarea está completada.
    );
  }

  Widget _buildListaTareas() {
    return ListView.builder(
      itemCount: gestorDeTareas
          .tareas.length, // La cantidad de elementos es la cantidad de tareas.
      itemBuilder: (context, index) {
        final tarea = gestorDeTareas
            .tareas[index]; // Obtiene la tarea actual basada en el índice.
        return _buildItemListaTarea(tarea, index);
      },
    );
  }

  void _mostrarDialogoDeConfirmacion(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // El usuario debe tocar un botón para cerrar el diálogo
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación de salida'),
          content: const Text('¿Estás seguro de que quieres salir?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Cierra el diálogo sin hacer nada más
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(); // Primero cierra el diálogo
                Navigator.of(context).pop(); // Luego cierra la pantalla actual
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Gestor de Tareas'), // Título de la aplicación.
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons
                .exit_to_app),
            onPressed: () => _mostrarDialogoDeConfirmacion(context),
          ),
        ],
      ), // AppBar es la barra superior de la aplicación.
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildFieldTarea(),
          ),
          Expanded(
            child: _buildListaTareas(),
          ),
        ],
      ),
    );
  }
}
