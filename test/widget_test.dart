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

    test('comprobamos que se ha ordenado bien las tareas.', () {
      gestorDeTareas.agregarTarea(tarea);
      Tarea tarea2 = Tarea(descripcion: 'Segunda tarea de prueba');
      gestorDeTareas.agregarTarea(tarea2);
      Tarea tarea3 = Tarea(descripcion: 'Cuarta tarea de prueba');
      gestorDeTareas.agregarTarea(tarea3);
      gestorDeTareas.ordenarTareasPorDescripcion();
      expect(gestorDeTareas.tareas[0].descripcion, 'Cuarta tarea de prueba');
      expect(gestorDeTareas.tareas[2].descripcion, 'Tarea de prueba');
    });

    test('comprobamos que se establece bien la prioridad.', () {
      gestorDeTareas.agregarTarea(tarea);
      // Primero tiene prioridad normal
      expect(gestorDeTareas.tareas[0].prioridad, 2);
      gestorDeTareas.establecerPrioridadTarea(0);
      // Despues tiene prioridad alta
      expect(gestorDeTareas.tareas[0].prioridad, 1);
    });

    test('comprobamos que se intercambia bien las tareas.', () {
      gestorDeTareas.agregarTarea(tarea);
      Tarea tarea2 = Tarea(descripcion: 'Segunda tarea de prueba');
      gestorDeTareas.agregarTarea(tarea2);
      // Comprobamos que esta en el orden original
      expect(gestorDeTareas.tareas[0].descripcion, 'Tarea de prueba');
      expect(gestorDeTareas.tareas[1].descripcion, 'Segunda tarea de prueba');
      // Aplicamos el intercambio
      gestorDeTareas.intercambiarTareas(0, 1);
      // Comprobamos que se ha intercambiado
      expect(gestorDeTareas.tareas[0].descripcion, 'Segunda tarea de prueba');
      expect(gestorDeTareas.tareas[1].descripcion, 'Tarea de prueba');
      // Comprobamos que si introducimos mal los indices lanza excepción
      expect(() => gestorDeTareas.intercambiarTareas(0, 2), throwsException);
      expect(() => gestorDeTareas.intercambiarTareas(2, 0), throwsException);
      expect(() => gestorDeTareas.intercambiarTareas(0, 0), throwsException);
      expect(() => gestorDeTareas.intercambiarTareas(-1, 0), throwsException);
      expect(() => gestorDeTareas.intercambiarTareas(0, -1), throwsException);
    });
  });
}
