import '../tarea/tarea.dart';

// Al no tener que inicializar atributos, no es necesario un constrcutor.
class GestorDeTareas {
  List<Tarea> tareas = [];

  GestorDeTareas();

  void agregarTarea(Tarea tarea) {
    if (tarea.descripcion.isNotEmpty) tareas.add(tarea);
  }

  void eliminarTarea(int index) {
    tareas.removeAt(index);
  }

  void marcarComoCompletada(int index) {
    tareas[index].completada = !tareas[index].completada;
  }

  void modificarTarea(int index, String nuevaDescripcion) {
    if (nuevaDescripcion.isNotEmpty) tareas[index].descripcion = nuevaDescripcion;
  }
}
