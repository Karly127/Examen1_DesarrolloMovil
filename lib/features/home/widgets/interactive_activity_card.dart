import 'package:flutter/material.dart';
import 'package:flutter_application_1_emulador/features/home/models/activity.dart';
import 'package:flutter_application_1_emulador/features/details/screens/detail_screen.dart';

class InteractiveActivityCard extends StatefulWidget {
  final Activity activity;

  const InteractiveActivityCard({
    super.key,
    required this.activity,
  });

  @override
  State<InteractiveActivityCard> createState() => _InteractiveActivityCardState();
}

class _InteractiveActivityCardState extends State<InteractiveActivityCard> {
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isComplete ? Colors.green.shade100 : Colors.white,
      elevation: 4.0, //sombra de la tarjeta
      child: ListTile(
        title: Text(widget.activity.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(isComplete ? 'Actividad completada' : 'Pendiente de completar'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(activity: widget.activity), // Pasa la actividad al DetailScreen
            ),
          );
        },
        trailing: IconButton(
          onPressed: () {
            setState(() {
              isComplete = !isComplete;
            });
          },
          icon: Icon(isComplete ? Icons.check_circle : Icons.radio_button_unchecked, 
          color: isComplete ? Colors.white : Colors.grey),
        ),
        
        leading: Icon(Icons.fitness_center, color: Colors.green, size: 40.0),
      ),
    );
  }
}

     