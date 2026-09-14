import 'package:flutter/material.dart';
import 'package:flutter_application_1_emulador/features/details/screens/perfil_screen.dart';
import 'package:flutter_application_1_emulador/features/home/models/activity.dart';
import 'package:flutter_application_1_emulador/features/home/widgets/interactive_activity_card.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Activity> activityList = [
    Activity(title: 'Pasos diarios', subtitle: 'Caminata diaria', icon: Icons.directions_walk, trailingText: '5,000', iconColor: Colors.blue),
    Activity(title: 'Rutina de fuerza', subtitle: 'Tren superior / pesas', icon: Icons.fitness_center, trailingText: 'Hecho', iconColor: Colors.blue),
    Activity(title: 'Rutina de yoga', subtitle: 'Flexibilidad / meditación', icon: Icons.local_florist, trailingText: 'Hecho', iconColor: Colors.blue),
    Activity(title: 'Natación', subtitle: 'Estilo libre', icon: Icons.pool, trailingText: '60 metros', iconColor: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.white,
        title: Text('Panel de actividad física'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Perfil',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: activityList.length,
          itemBuilder: (context, index) {
            final currentActivity = activityList[index];
            return InteractiveActivityCard(
              activity: currentActivity,
            );
          },
         /*Column(children: [
          Text('Resumen de hoy', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          //SizedBox(height: 16.0),
          ActivityCard(
            title: 'Pasos diarios', 
            subtitle: 'Caminata diaria', 
            icon: Icons.directions_walk, trailingText: '5,000', 
            iconColor: Colors.blue
          ),
          ActivityCard(
            title: 'Rutina de fuerza', 
            subtitle: 'Tren superior / pesas', 
            icon: Icons.fitness_center, trailingText: 'Hecho', 
            iconColor: Colors.blue
          ),
          ActivityCard(
            title: 'Rutina de yoga', 
            subtitle: 'Flexibilidad / meditación', 
            icon: Icons.local_florist, trailingText: 'Hecho', 
            iconColor: Colors.blue
          ),
          ActivityCard(
            title: 'Natación', 
            subtitle: 'Estilo libre', 
            icon: Icons.pool, trailingText: '60 metros', 
            iconColor: Colors.blue
          ),
          InteractiveActivityCard(title: 'Pasos diarios',),
          InteractiveActivityCard(title: 'Pesas',),
          InteractiveActivityCard(title: 'Yoga',),
          InteractiveActivityCard(title: 'Natación',),
        ],*/
      ),
    ),
    );
  }
}

