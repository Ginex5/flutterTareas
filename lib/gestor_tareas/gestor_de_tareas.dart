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
    if (nuevaDescripcion.isNotEmpty)
      tareas[index].descripcion = nuevaDescripcion;
  }

  void ordenarTareasPorDescripcion() {
    tareas.sort((a, b) => a.descripcion.compareTo(b.descripcion));
  }

  void establecerPrioridadTarea(int index, int prioridad) {
    tareas[index].prioridad = prioridad;
  }

  void intercambiarTareas(int index1, int index2) {
    if (index1 != index2 &&
        index1 >= 0 &&
        index1 < tareas.length &&
        index2 >= 0 &&
        index2 < tareas.length) {
      var temp = tareas[index1];
      tareas[index1] = tareas[index2];
      tareas[index2] = temp;
    }else{
      throw Exception('Los índices no son válidos.');
    }
  }
}
