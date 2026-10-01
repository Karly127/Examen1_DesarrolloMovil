import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pedometer/pedometer.dart';

class StepCounterCard extends StatefulWidget {
  const StepCounterCard({super.key});

  @override
  State<StepCounterCard> createState() => _StepCounterCardState();
}

class _StepCounterCardState extends State<StepCounterCard> {
  late Stream<StepCount> _stepCountStream;
  bool _permisonConcedido = false;

  @override
  void initState() {
    super.initState();
    _verificarPermisoInicial();
  }

  // Verifica el permiso automáticamente al cargar la pantalla
  Future<void> _verificarPermisoInicial() async {
    if (await Permission.activityRecognition.isGranted) {
      _activarPodometro();
    }
  }

  Future<void> _solicitarPermiso() async {
    PermissionStatus status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      _activarPodometro();
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // Abre los ajustes si el usuario denegó permanentemente
    }
  } 

  void _activarPodometro() {
    setState(() {
      _permisonConcedido = true;
      _stepCountStream = Pedometer.stepCountStream;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade100,
      elevation: 5.0,
      margin: EdgeInsets.only(bottom: 15.0),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.directions_walk, color: Colors.blue, size: 30.0),
                SizedBox(width: 10.0),
                Text('Pasos de hoy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 15.0),
            if(_permisonConcedido)
              StreamBuilder<StepCount>(
                stream: _stepCountStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Pasos: ${snapshot.data!.steps}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error al leer el sensor');
                  } else {
                    // Se mostrará hasta que des el primer paso físico
                    return Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text('Camina para registrar el primer paso...'),
                      ],
                    );
                  }
                },
              )
            else
              ElevatedButton(
                onPressed: _solicitarPermiso,
                child: Text('Solicitar permiso para contar pasos'),
              ),
          ],
        ),
      ),
    );
  }
}