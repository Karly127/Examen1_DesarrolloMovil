import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
           
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blueAccent,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
           
            const Text(
              'Park Jihoon', 
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
           
            const Divider(
              thickness: 1.5,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 16),
           
            const Text('Estadísticas Físicas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Aqui empieza la primera tarjeta, porque me revolvi
                Expanded(
                  child: Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: const [
                          Icon(Icons.check_circle_outline, color: Colors.green, size: 30),
                          SizedBox(height: 8),
                          Text(
                            'Completados',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('4 Entrenamientos', textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  ),
                ),
                // aqui es la segunda tarjeta
                Expanded(
                  child: Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: const [
                          Icon(Icons.fitness_center, color: Colors.blue, size: 30),
                          SizedBox(height: 8),
                          Text(
                            'Último registro',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Entrenamiento de futbol'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}