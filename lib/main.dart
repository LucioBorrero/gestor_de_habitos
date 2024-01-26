import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Definición de la aplicación principal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 54, 152, 244)),
        useMaterial3: true,
      ),
      home: const HabitManager(),
    );
  }
}

// Definición del widget HabitManager como StatefulWidget
class HabitManager extends StatefulWidget {
  const HabitManager({super.key});

  @override
  _HabitManagerState createState() => _HabitManagerState();
}

// Estado asociado al widget HabitManager
class _HabitManagerState extends State<HabitManager> {
  List<String> habits = [];  // Lista para almacenar hábitos

  // Método para agregar un hábito a la lista
  void addHabit(String habit) {
    setState(() {
      habits.add(habit);
    });
  }

  // Método para eliminar un hábito de la lista
  void removeHabit(int index) {
    setState(() {
      habits.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Gestor de Hábitos'),
      ),
      body: Column(
        children: [
          // Botón elevado para mostrar un diálogo y agregar un hábito
          ElevatedButton(
            onPressed: () async {
              String newHabit = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Text('Ingrese un hábito'),
                    children: [
                      TextField(
                        onSubmitted: (habit) {
                          Navigator.pop(context, habit);
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, null);
                        },
                        child: Text('Cancelar'),
                      ),
                    ],
                  );
                },
              );

              if (newHabit != null) {
                addHabit(newHabit);
              }
            },
            child: Text('Ingresar Hábito'),
          ),
          // Lista expandida para mostrar hábitos con opción de eliminación
          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(habits[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      removeHabit(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
