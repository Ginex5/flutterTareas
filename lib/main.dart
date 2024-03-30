import 'package:flutter/material.dart';
import 'gestor_de_tareas.dart';
import 'tarea.dart';

void main() {
  runApp(const MiAppDeTareas());
}

class MiAppDeTareas extends StatelessWidget {
  const MiAppDeTareas({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PantallaDeTareas(),
    );
  }
}

class PantallaDeTareas extends StatefulWidget {
  const PantallaDeTareas({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PantallaDeTareasState createState() => _PantallaDeTareasState();
}

class _PantallaDeTareasState extends State<PantallaDeTareas> {
  final GestorDeTareas gestorDeTareas = GestorDeTareas();
  final TextEditingController controladorTexto = TextEditingController();

  void _agregarTarea() {
    setState(() {
      gestorDeTareas.agregarTarea(Tarea(descripcion: controladorTexto.text));
      controladorTexto.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestor de Tareas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controladorTexto,
              decoration: InputDecoration(
                labelText: 'Descripción de la tarea',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _agregarTarea,
                ),
              ),
              onSubmitted: (value) => _agregarTarea(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gestorDeTareas.tareas.length,
              itemBuilder: (context, index) {
                final tarea = gestorDeTareas.tareas[index];
                return ListTile(
                  title: Text(tarea.descripcion),
                  leading: IconButton(
                    icon: Icon(tarea.completada ? Icons.check_box : Icons.check_box_outline_blank),
                    onPressed: () => setState(() {
                      gestorDeTareas.marcarComoCompletada(index);
                    }),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => setState(() {
                      gestorDeTareas.eliminarTarea(index);
                    }),
                  ),
                  tileColor: tarea.completada ? Colors.green[100] : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
