import 'package:flutter_test/flutter_test.dart';
import 'package:tareas/gestor_tareas/gestor_de_tareas.dart';
import 'package:tareas/tarea/tarea.dart';

void main() {
  group('Operaciones en tareas: ', () {
    late GestorDeTareas gestorDeTareas;
    late Tarea tarea;

    setUp(() {
      // Inicializar el gestor de tareas y la tarea antes de cada test
      gestorDeTareas = GestorDeTareas();
      tarea = Tarea(descripcion: 'Tarea de prueba');
    });

    test(
        'comprobamos que se agrega una tarea, y no se puede crear una con la descipción vacía.',
        () {
      final tarea1 = Tarea(descripcion: '');
      gestorDeTareas.agregarTarea(tarea);
      gestorDeTareas.agregarTarea(tarea1);
      expect(gestorDeTareas.tareas.contains(tarea), true);
      expect(gestorDeTareas.tareas.contains(tarea1), false);
    });

    test('comprobamos que se elimina una tarea.', () {
      gestorDeTareas.agregarTarea(tarea);
      gestorDeTareas.eliminarTarea(0);
      expect(gestorDeTareas.tareas.contains(tarea), false);
    });

    test('comprobamos que se completa una tarea y que desmarca.', () {
      gestorDeTareas.agregarTarea(tarea);
      gestorDeTareas.marcarComoCompletada(0);
      expect(gestorDeTareas.tareas[0].completada, true);
      gestorDeTareas.marcarComoCompletada(0);
      expect(gestorDeTareas.tareas[0].completada, false);
    });

    test(
        'comprobamos que se ha modificado una tarea, y no se puede modificar con una descripción vacía.',
        () {
      gestorDeTareas.agregarTarea(tarea);
      gestorDeTareas.modificarTarea(0, "Modificada");
      expect(gestorDeTareas.tareas[0].descripcion, "Modificada");
      gestorDeTareas.modificarTarea(0, "");
      expect(gestorDeTareas.tareas[0].descripcion, "Modificada");
    });
  });
}
