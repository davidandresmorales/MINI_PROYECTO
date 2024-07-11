import 'dart:io';
import 'dart:math';

class Tema {
  String nombre;
  int cantidadEstudiantes;

  Tema(this.nombre, this.cantidadEstudiantes);
}

class Estudiante {
  String nombre;

  Estudiante(this.nombre);
}

List<Tema> temas = [];
List<Estudiante> estudiantes = [];
Map<Tema, List<Estudiante>> asignaciones = {};

void main() {
  precargarDatos();
  int opcion;
  do {
    printMenu();
    opcion = int.parse(stdin.readLineSync()!);
    switch (opcion) {
      case 1:
        crearTema();
        break;
      case 2:
        editarTema();
        break;
      case 3:
        mostrarTemas();
        break;
      case 4:
        eliminarTema();
        break;
      case 5:
        ingresarEstudiante();
        break;
      case 6:
        editarEstudiante();
        break;
      case 7:
        mostrarEstudiantes();
        break;
      case 8:
        eliminarEstudiante();
        break;
      case 9:
        asignarYMostrarEstudiantes();
        break;
      case 10:
        resetearAsignaciones();
        break;
      case 0:
        print('Saliendo...');
        break;
      default:
        print('Opción no válida');
        break;
    }
  } while (opcion != 0);
}

void printMenu() {
  print('''\nMenu:
1. Crear tema de exposición
2. Editar tema de exposición
3. Mostrar temas de exposición
4. Eliminar tema de exposición
5. Ingresar estudiante
6. Editar estudiante
7. Mostrar estudiantes
8. Eliminar estudiante
9. Asignar estudiantes a temas de forma aleatoria y mostrar asignaciones
10. Resetear asignaciones
0. Salir
Seleccione una opción:''');
}

void crearTema() {
  print('Ingrese el nombre del tema:');
  String nombre = stdin.readLineSync()!;
  print('Ingrese la cantidad de estudiantes necesarios:');
  int cantidadEstudiantes = int.parse(stdin.readLineSync()!);
  temas.add(Tema(nombre, cantidadEstudiantes));
  print('Tema creado exitosamente');
}

void editarTema() {
  mostrarTemas();
  print('Ingrese el número del tema a editar:');
  int index = int.parse(stdin.readLineSync()!);
  if (index >= 0 && index < temas.length) {
    print('Ingrese el nuevo nombre del tema:');
    String nombre = stdin.readLineSync()!;
    print('Ingrese la nueva cantidad de estudiantes necesarios:');
    int cantidadEstudiantes = int.parse(stdin.readLineSync()!);
    temas[index].nombre = nombre;
    temas[index].cantidadEstudiantes = cantidadEstudiantes;
    print('Tema editado exitosamente');
  } else {
    print('Índice no válido');
  }
}

void mostrarTemas() {
  print('Temas de exposición:');
  for (int i = 0; i < temas.length; i++) {
    print('$i. ${temas[i].nombre} (Estudiantes necesarios: ${temas[i].cantidadEstudiantes})');
  }
}

void eliminarTema() {
  mostrarTemas();
  print('Ingrese el número del tema a eliminar:');
  int index = int.parse(stdin.readLineSync()!);
  if (index >= 0 && index < temas.length) {
    temas.removeAt(index);
    print('Tema eliminado exitosamente');
  } else {
    print('Índice no válido');
  }
}

void ingresarEstudiante() {
  print('Ingrese el nombre completo del estudiante:');
  String nombre = stdin.readLineSync()!;
  estudiantes.add(Estudiante(nombre));
  print('Estudiante ingresado exitosamente');
}

void editarEstudiante() {
  mostrarEstudiantes();
  print('Ingrese el número del estudiante a editar:');
  int index = int.parse(stdin.readLineSync()!);
  if (index >= 0 && index < estudiantes.length) {
    print('Ingrese el nuevo nombre completo del estudiante:');
    String nombre = stdin.readLineSync()!;
    estudiantes[index].nombre = nombre;
    print('Estudiante editado exitosamente');
  } else {
    print('Índice no válido');
  }
}

void mostrarEstudiantes() {
  print('Estudiantes:');
  for (int i = 0; i < estudiantes.length; i++) {
    print('$i. ${estudiantes[i].nombre}');
  }
}

void eliminarEstudiante() {
  mostrarEstudiantes();
  print('Ingrese el número del estudiante a eliminar:');
  int index = int.parse(stdin.readLineSync()!);
  if (index >= 0 && index < estudiantes.length) {
    estudiantes.removeAt(index);
    print('Estudiante eliminado exitosamente');
  } else {
    print('Índice no válido');
  }
}

void asignarYMostrarEstudiantes() {
  if (temas.isEmpty || estudiantes.isEmpty) {
    print('No hay suficientes temas o estudiantes para asignar');
    return;
  }

  List<Estudiante> estudiantesSinAsignar = List.from(estudiantes);
  Random random = Random();

  for (Tema tema in temas) {
    asignaciones[tema] = [];
  }

  for (Tema tema in temas) {
    for (int i = 0; i < tema.cantidadEstudiantes; i++) {
      if (estudiantesSinAsignar.isNotEmpty) {
        int indexAleatorio = random.nextInt(estudiantesSinAsignar.length);
        Estudiante estudianteAsignado = estudiantesSinAsignar.removeAt(indexAleatorio);
        asignaciones[tema]!.add(estudianteAsignado);
      }
    }
  }

  if (estudiantesSinAsignar.isNotEmpty) {
    print('Advertencia: Algunos estudiantes no pudieron ser asignados.');
  }

  mostrarAsignaciones();
}

void mostrarAsignaciones() {
  print('Asignaciones:');
  asignaciones.forEach((tema, estudiantesAsignados) {
    print('${tema.nombre} (Estudiantes asignados: ${tema.cantidadEstudiantes}):');
    for (Estudiante estudiante in estudiantesAsignados) {
      print('  - ${estudiante.nombre}');
    }
  });
}

void resetearAsignaciones() {
  asignaciones.clear();
  print('Asignaciones reseteadas exitosamente');
}

void precargarDatos() {
  temas = [
    Tema('¿Qué es la programación orientada a objetos?', 3),
    Tema('¿Cuáles son las características principales de la programación orientada a objetos?', 3),
    Tema('¿Cuál es la diferencia entre la programación orientada a objetos y programación estructurada?', 3),
    Tema('¿Qué es un objeto? ¿Qué es una clase? ¿Cuál es la diferencia entre objeto y clase?', 3),
    Tema('¿Qué es abstracción?', 3),
    Tema('¿Qué es encapsulamiento?', 3),
    Tema('¿Qué es herencia?', 3),
    Tema('¿Qué es polimorfismo? Dé un ejemplo.', 3),
    Tema('¿Cuáles son los principales diagramas de UML?', 3)
  ];

  estudiantes = [
    Estudiante('ANDRES FELIPE SANCHEZ HURTADO'),
    Estudiante('ANGIE DAHIANA RIOS QUINTERO'),
    Estudiante('CRISTIAN ALVAREZ ARANZAZU'),
    Estudiante('DANIEL ESTIVEN ARBOLEDA DUQUE'),
    Estudiante('DAVID ANDRES MORALES GUAPACHA'),
    Estudiante('DAVID STIVEN OCAMPO LONDOÑO'),
    Estudiante('ESTEBAN REYES AGUDELO'),
    Estudiante('JACOBO GALVIS JIMENEZ'),
    Estudiante('JAIME ANDRES CALLE SALAZAR'),
    Estudiante('JEFERSON MAURICIO HERNANDEZ LADINO'),
    Estudiante('JHON ALEXANDER PINEDA OSORIO'),
    Estudiante('JOSE MIGUEL SIERRA ARISTIZABAL'),
    Estudiante('JOSÉ SEBASTIÁN OCAMPO LÓPEZ'),
    Estudiante('JUAN ANDRES OSORIO GOMEZ'),
    Estudiante('JUAN DIEGO CALVO OSORIO'),
    Estudiante('JUAN ESTEBAN LOPEZ CALLE'),
    Estudiante('JUAN PABLO RIOS ARISTIZABAL'),
    Estudiante('MARIA PAULA MELO SOLANO'),
    Estudiante('MIGUEL ANGEL PEÑA JIMENEZ'),
    Estudiante('SAMUEL CASTAÑO CARDONA'),
    Estudiante('JUAN JOSÉ POSADA PÉREZ'),
    Estudiante('ALEJANDRO SERNA LONDOÑO'),
    Estudiante('JUAN MANUEL ZULUAGA RINCON'),
    Estudiante('JUAN DANIEL GOMEZ LASERNA'),
    Estudiante('YERSON STIVEN HERRERA OBANDO'),
    Estudiante('MATEO HERRERA VARGAS'),
    Estudiante('ALEJANDRO VALLEJO ESCOBAR')
  ];

  print('Datos precargados exitosamente');
}
