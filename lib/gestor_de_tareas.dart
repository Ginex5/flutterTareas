import 'tarea.dart';

// Al no tener que inicializar atributos, no es necesario un constrcutor.
class GestorDeTareas {
  List<Tarea> tareas = [];

  void agregarTarea(Tarea tarea) {
    tareas.add(tarea);
  }

  void eliminarTarea(int index) {
    tareas.removeAt(index);
  }

  void marcarComoCompletada(int index) {
    tareas[index].completada = !tareas[index].completada;
  }
}
